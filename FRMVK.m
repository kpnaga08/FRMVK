%% This is a matlab function of A feature-reduction multi-view k-means clustering algorithm
% Written by Kristina P. Sinaga (kristinasinaga57@yahoo.co.id)

% INPUTS:
% X: input data matrix. 
% c: Desired number of clusters


% Notation:
% X ... a cell containing all views for the data
% label ... ground truth labels
% clust ... predict labels


clear all;close all;clc

load 4C3D2V_DATA.mat
X = points;


d_h   =[size(X{1},2) size(X{2},2)];            
s =size(d_h,2);
c =4;


X = cell2mat(X);
[n d]=size(X);

%% Generate initialization of membership
rng(1)
idx=randi(c,[n,1]);
u=zeros(n,c);
for i=1:n
    u(i,idx(i))=1;
end


%% feature weight initialization
rng(27)
x1=1:d_h(1);wf1=x1/sum(x1,2);
x2=1:d_h(2);wf2=x2/sum(x2,2);
wf=[wf1 wf2];

%% view weight initialization
rng(26)
x=rand([1 s]);wv=x/sum(x,2);

alpha=3;
rate=0;
err_wf=10;
err_wv=10;
thres=eps;

index_wf_red_all=[];

while and(err_wf>thres,err_wv>thres)
rate=rate+1;


    delta=(sqrt(abs(mean(X))))./var(X);
    

    %% Computing cluster center A
    
    A=[];
    for k=1:c
            temp4=zeros(1,d);
            temp5=0;
            for i=1:n
                temp4=temp4+u(i,k)*X(i,:);
                temp5=temp5+u(i,k);
            end
        A=[A; temp4/temp5];
    end
    A;
    clear temp4 temp5
    
    %% Updating membership U
    
    new_u=[];
    u8=[];
    for k=1:c
        u7=[];
        j=0;
        for h=1:s
            X_temp=X(:,j+1:j+d_h(h));
            A_temp=A(:,j+1:j+d_h(h));
            wf_temp=wf(:,j+1:j+d_h(h));
            delta_temp=delta(:,j+1:j+d_h(h));
            
            u1=bsxfun(@minus,X_temp,A_temp(k,:));
            u2=u1.^2;
            u3=bsxfun(@times,u2,delta_temp);
            u4=bsxfun(@times,u3,wf_temp);
            u5=sum(u4,2);
            u6=bsxfun(@times,u5,wv(h)^alpha);
            u7=[u7 u6];
            j=j+d_h(h);
        end
        u8=[u8 sum(u7,2)];
    end
   
        new_u=zeros(n,c);
        for i=1:n
            [val,idx]=min(u8(i,:));
            new_u(i,idx)=1;
        end
        u=new_u;
        clear u1 u2 u3 u4 u5 u6 u7 u8 X_temp A_temp wf_temp delta_temp val
        j=0;
        
        
    %% updating feature weight
    
    new_wf=[];
    j=0;
    for h=1:s
        X_temp=X(:,j+1:j+d_h(h));
        A_temp=A(:,j+1:j+d_h(h));
        wf_temp=wf(:,j+1:j+d_h(h));
        delta_temp=delta(:,j+1:j+d_h(h));
        W5=[];
        for k=1:c
            W1=bsxfun(@minus,X_temp,A_temp(k,:)); 
            W2=W1.^2; 
            W3=bsxfun(@times,W2,u(:,k));
            W4=sum(W3,1);
            W5=[W5; W4];
        end
        W6=sum(W5,1);
        W7=bsxfun(@times,W6,delta_temp);
        W8=bsxfun(@times,wv(h)^alpha,W7);
        W9=(-d_h(h).*W8)./n;
        W10=exp(W9);
        W11=1./delta_temp;
        W12=bsxfun(@times,W10,W11);
        W13=sum(W12,2);
        W14=bsxfun(@rdivide,W12,W13);
        new_wf=[new_wf W14];
        j=j+d_h(h);
    end
    clear W1 W2 W3 W4 W5 W6 W7 W8 W9 W10 W11 W12 W13 W14 X_temp A_temp delta_temp
    
    %% Updating view weight

    j=0;
    V10=[];
    V8=[];
    new_wv=[];
    for h=1:s
        X_temp=X(:,j+1:j+d_h(h));
        A_temp=A(:,j+1:j+d_h(h));
        new_wf_temp=new_wf(:,j+1:j+d_h(h));
        delta_temp=delta(:,j+1:j+d_h(h));

        for k=1:c
            V1=bsxfun(@minus,X_temp,A_temp(k,:)); 
            V2=V1.^2; 
            V3=bsxfun(@times,delta_temp,V2);
            V4=bsxfun(@times,new_wf_temp,V3);
            V5=sum(V4,2);
            V6=bsxfun(@times,V5,u(:,k));
            V7=sum(V6,1);
            V8=[V8; V7];
        end
        V9=sum(V8,1);
        V10=[V10 V9];
        j=j+d_h(h);
    end
    V11=V10.^(-1/(alpha-1));
    V12=sum(V11,2);
    V13=bsxfun(@rdivide,V11,V12);
    new_wv=[new_wv V13];
    clear V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 X_temp A_temp new_wf_temp delta_temp
    
    
    %% discard weight
    new_d_h=[]; new_wf2=[]; new_X2=[]; new_A=[]; index_wf_red=[];
    
    j=0;
    for h=1:s
        thres_reduce=1/sqrt(n*d_h(h));
        
        new_wf_temp=new_wf(:,j+1:j+d_h(h));
        index_wf=find(new_wf_temp<thres_reduce);
        index_wf_red=[index_wf_red j+find(new_wf_temp<thres_reduce)];
        index_wf_ok=find(new_wf_temp>=thres_reduce);
        
        %% adjust weight
        adj_wf=new_wf_temp;
        adj_wf(index_wf)=[];
        adj_wf=adj_wf/sum(adj_wf);
        new_wf_temp2=adj_wf;
        
        %% Update number of dimension
        new_d=size(new_wf_temp2,2);
        new_d_h=[new_d_h new_d];
        new_wf2=[new_wf2 new_wf_temp2];
        
        j=j+d_h(h);
    
    end
    index_wf_red_all=[index_wf_red_all index_wf_red]
    
    %% adjust points
    new_X=X; new_X(:,index_wf_red)=[]; delta(index_wf_red)=[];
    
    %% adjust cluster center
    new_A=A; A(:,index_wf_red)=[];
    
    new_wf=new_wf2; X=new_X; d=size(X,2); d_h=new_d_h;
    
    
    err_wf=abs(norm(wf)-norm(new_wf));
    err_wv=norm(wv-new_wv);
    
    wf=new_wf;
    wv=new_wv;
    A=new_A;
    
    clear new_wf new_wf new_A
end
     
 clust=[];
        for i=1:n
            [num idx]=max(u(i,:));
            clust=[clust;idx];
        end


%% Evaluation metric        

[AR,RI]=RandIndex(label,clust);AR=1-ErrorRate(label,clust,c)/n;
[AR RI]
       
