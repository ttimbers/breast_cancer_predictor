Exploratory data analysis of the Wisconsin Breast Cancer data set
================

# Summary of the data set

The data set used in this project is of digitized breast cancer image
features created by Dr. William H. Wolberg, W. Nick Street, and Olvi L.
Mangasarian at the University of Wisconsin, Madison (Street, Wolberg,
and Mangasarian 1993). It was sourced from the UCI Machine Learning
Repository (Dua and Graff 2017) and can be found
[here](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+\(Diagnostic\)),
specifically [this
file](http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data).
Each row in the data set represents summary statistics from measurements
of an image of a tumour sample, including the diagnosis (benign or
malignant) and several other measurements (e.g., nucleus texture,
perimeter, area, etc.). Diagnosis for each image was conducted by
physicians. There are 569 observations in the data set, and 31 features.
There are 0 observations with missing values in the data set. Below we
show the number of each observations for each of the classes in the data
set.

| Benign cases | Malignant cases |
| -----------: | --------------: |
|          357 |             212 |

Table 1. Counts of observation for each class.

# Partition the data set into training and test sets

Before proceeding further, we will split the data such that 75% of
observations are in the training and 25% of observations are in the test
set. Below we list the counts of observations for each class:

| Data partition | Benign cases | Malignant cases |
| :------------- | -----------: | --------------: |
| Training       |          268 |             159 |
| Test           |           89 |              53 |

Table 2. Counts of observation for each class for each data partition.

There is a minor class imbalance, but it is not so great that we will
plan to immediately start our modeling plan with over- or
under-sampling. If during initial tuning, there are indicators that it
may in fact be a greater problem than anticipated (e.g., if the
confusion matrix indicates that the model makes a lot more mistakes on
the minority class, here malignant cases) then we will only then start
to explore whether empoying techniques to address class imbalance may be
of help to improving model performance in regards to predicting the
minority class.

# Exploratory analysis on the training data set

To look at whether each of the predictors might be useful to predict the
tumour class, we plotted the distributions of each predictor from the
training data set and coloured the distribution by class (benign: blue
and malignant: orange). In doing this we see that class distributions
for all of the mean and max predictors for all the measurements overlap
somewhat, but do show quite a difference in their centres and spreads.
This is less so for the standard error (se) predictors. In particular,
the standard errors of fractal dimension, smoothness, symmetry and
texture look very similar in both the distribution centre and spread.
Thus, we might choose to omit these from our
model.

![](breast_cancer_eda_files/figure-gfm/predictor%20distributions-1.png)<!-- -->

Figure 1. Distribution of training set predictors for the benign (B) and
malignant (M) tumour cases.

# References

<div id="refs" class="references">

<div id="ref-Dua2019">

Dua, Dheeru, and Casey Graff. 2017. “UCI Machine Learning Repository.”
University of California, Irvine, School of Information; Computer
Sciences. <http://archive.ics.uci.edu/ml>.

</div>

<div id="ref-Streetetal">

Street, W. Nick, W. H. Wolberg, and O. L. Mangasarian. 1993. “Nuclear
feature extraction for breast tumor diagnosis.” In *Biomedical Image
Processing and Biomedical Visualization*, edited by Raj S. Acharya and
Dmitry B. Goldgof, 1905:861–70. International Society for Optics;
Photonics; SPIE. <https://doi.org/10.1117/12.148698>.

</div>

</div>
