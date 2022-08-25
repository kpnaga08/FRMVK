# Feature_Reduction_MVK

A matlab implementation of paper "A Feature-Reduction Multi-View k-Means Clustering Algorithm."

Published in [IEEE Access'19](https://ieeexplore.ieee.org/abstract/document/8793138/) <br /> 

# Demo: 
FRMVK.m: you can run this FRMVK file, and its performance will be recorded automatically.

# Initializations: 
c : the desired number of clusters <br />
s : the number of views <br />
n : the number of data points <br />
u : memberships <br />
wf: feature weight <br />
wv: view weight <br />

# Parameters:

alpha: the exponent for the view weights <br />
delta: a balance parameter to control the feature weights of the k-th cluster in each view <br />

**In case the repository or the publication was helpful in your work, please use the following to cite the original paper,**
<pre><code> @article{yang2019feature,<br />
  title={A feature-reduction multi-view k-means clustering algorithm},<br />
  author={Yang, Miin-Shen and Sinaga, Kristina P},<br />
  journal={IEEE Access},<br />
  volume={7},<br />
  pages={114472--114486},<br />
  year={2019},<br />
  publisher={IEEE}<br />
}
</code></pre>

## Abstract:
The k-means clustering algorithm is the oldest and most known method in cluster analysis.
It has been widely studied with various extensions and applied in a variety of substantive areas. Since
internet, social network, and big data grow rapidly, multi-view data become more important. For analyzing
multi-view data, various multi-view k-means clustering algorithms have been studied. However, most of
multi-view k-means clustering algorithms in the literature cannot give feature reduction during clustering
procedures. In general, there often exist irrelevant feature components in multi-view data sets that may cause
bad performance for these clustering algorithms. There also exists high feature dimension in multi-view data
sets so it is necessary to consider reducing its dimension for clustering algorithms. In this paper, a learning
mechanism for the multi-view k-means algorithm to automatically compute individual feature weight is
constructed. It can reduce these irrelevant feature components in each view. A new multi-view k-means
objective function is firstly proposed for constructing the learning mechanism for feature weights in multiview clustering. A schema for eliminating irrelevant feature(s) with small weight(s) is then considered
for feature reduction. Therefore, a new type of multi-view k-means, called a feature-reduction multi-view
k-means (FRMVK), is proposed. The computational complexity of FRMVK is also analyzed. Numerical
and real data sets are used to compare FRMVK with other feature-weighted multi-view k-means algorithms.
Experimental results and comparisons actually demonstrate the effectiveness and usefulness of the proposed
FRMVK clustering algorithm.

**Data: CALTECH-101 Image set** <br />
The most un-convenient image data for multi-view clustering is the Caltech-101 data set. This Caltech-101 data set openly available and accessible at
http://www.vision.caltech.edu/Image_Datasets/Caltech101/Caltech101.html website. This
Caltech 101 consists of a total of 9.146 images belonging to 101 categories. These 101
categories are Faces, Faces easy, Leopard, Motorbikes, accordion, airplanes, anchor, ant,
barrel, bass, beaver, binocular, bonsai, brain, brontosaurus, buddha, butterfly, camera, cannon,
car side, ceiling fan, cell-phone, chair, chandelier, cougar body, cougar face, crab, cry fish,
crocodile, crocodile head, cup, dalmatian, dollar bill, dolphin, dragonfly, electric guitar,
elephant, emu, euphonium, ewer, faces, ferry, flamingo, flamingo head, Garfield, gerenuk,gramophone, grand piano, hawksbill, headphone, hedgehog, helicopter, ibis, inline skate, Joshua tree, kangaroo, ketch, lamp, laptop, llama, lobster, lotus, mandolin, mayfly, menorah,
metronome, minaret, nautilus, octopus, okapi, pagoda, panda, pigeon, pizza, platypus, pyramid,
revolver, rhino, rooster, saxophone, schooner, scissors, scorpion, sea horse, snoopy, soccer
ball, stapler, starfish, stegosaurus, stop sign, strawberry, sunflower, tick, trilobite, umbrella,
watch, water lily, wheelchair, wild cat, Windsor chair, wrench, and yin yang. We selected seven
classes of 101 categories with 1474 images, which are 435 possible images describes the
“Face”, 798 possible images describes the “motorbikes”, 52 possible images describe the
“Dollar bill”, 34 possible images describes the “Garfield”, 35 possible images describes
“Snoopy”, 64 possible images describes “stop-sign”, and 56 possible images describes the
“Windsor chair.” Each image is described by six views (48 features of Gabor, 254 features of
CENTRIST, 1984 features of the histogram of oriented gradients (HOG), 40 features of
wavelet moments, 928 features of local binary patterns (LBP), 512 features of GIST).

**Data: Image Segmentation** <br />
The Image segmentation (IS) data set contains 2310 instances of seven outdoor images.
These seven outdoor images are Brick-face, Sky, Foliage, Cement, Window, Path, and Grass.
Each instance is represented by two different views: 9 features of the shape information and 10
features of the RGB color. This data set is available at the UCI machine learning repository http://archive.ics.uci.edu/ml/datasets/Image+Segmentation 
