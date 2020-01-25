Predicting breast cancer from digitized images of breast mass
================
Tiffany A. Timbers </br>
2019/12/30 (updated: 2020-01-25)

# Summary

Here we attempt to build a classification model using the k-nearest
neighbours algorithm which can use breast cancer tumour image
measurements to predict whether a newly discovered breast cancer tumour
is benign (i.e., is not harmful and does not require treatment) or
malignant (i.e., is harmful and requires treatment intervention). Our
final classifier performed fairly well on an unseen test data set, with
Cohen’s Kappa score of 0.9 and an overall accuracy calculated to be
0.97. On the 142 test data cases, it correctly predicted 138. However it
incorrectly predicted 4 cases, and importantly these cases were false
negatives; predicting that a tumour is benign when in fact it is
malignant. These kind of incorrect predictions could have a severly
negative impact on a patients health outcome, thus we recommend
continuing study to improve this prediction model before it is put into
production in the clinic.

# Introduction

Women have a 12.1% lifetime probability of developing breast cancer, and
although cancer treatment has improved over the last 30 years, the
projected death rate for women’s breast cancer is 22.4 deaths per
100,000 in 2019 (Canadian Cancer Statistics Advisory Committee 2019).
Early detection has been shown to improve outcomes (Canadian Cancer
Statistics Advisory Committee 2019), and thus methods, assays and
technologies that help to improve diagnosis may be beneficial for
improving outcomes further.

Here we ask if we can use a machine learning algorithm to predict
whether a newly discovered tumour is benign or malignant given tumour
image measurements. Answering this question is important because
traditional methods for tumour diagnosis are quite subjective and can
depend on the diagnosing physicians skill as well as experience (Street,
Wolberg, and Mangasarian 1993). Furthermore, benign tumours are not
normally dangerous; the cells stay in the same place and the tumour
stops growing before it gets very large. By contrast, in malignant
tumours, the cells invade the surrounding tissue and spread into nearby
organs where they can cause serious damage. Thus, if a machine learning
algorithm can accurately and effectively predict whether a newly
discovered tumour benign or malignant given tumour image measurements
this could lead to less subjective, and more scalable breast cancer
tumour diagnosis which could contribute to better patient outcomes.

# Methods

## Data

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
physicians.

## Analysis

The k-nearest neighbors (k-nn) algorithm was used to build a
classification model to predict whether a tumour mass was benign or
malignant (found in the class column of the data set). All variables
included in the original data set, with the exception of the standard
error of fractal dimension, smoothness, symmetry and texture were used
to fit the model. The hyperparameter \(K\) was chosen using 30-fold
cross validation with Cohen’s Kappa as the classification metric. The R
and Python programming languages (R Core Team 2019; Van Rossum and Drake
2009) and the following R and Python packages were used to perform the
analysis: caret (Jed Wing et al. 2019), docopt (de Jonge 2018), feather
(Wickham 2019), knitr (Xie 2014), tidyverse (Wickham 2017), docopt
(Keleshev 2014), os (Van Rossum and Drake 2009), feather (McKinney 2019)
Pandas (McKinney 2010). The code used to perform the analysis and create
this report can be found here:
<https://github.com/ttimbers/breast_cancer_predictor>.

# Results & Discussion

To look at whether each of the predictors might be useful to predict the
tumour class, we plotted the distributions of each predictor from the
training data set and coloured the distribution by class (benign: blue
and malignant: orange). In doing this we see that class distributions
for all of the mean and max predictors for all the measurements overlap
somewhat, but do show quite a difference in their centres and spreads.
This is less so for the standard error (se) predictors. In particular,
the standard errors of fractal dimension, smoothness, symmetry and
texture look very similar in both the distribution centre and spread.
Thus, we choose to omit these from our
model.

<div class="figure">

<img src="../results/predictor_distributions_across_class.png" alt="Figure 1. Comparison of the empirical distributions of training data predictors between benign and malignant tumour masses." width="100%" />

<p class="caption">

Figure 1. Comparison of the empirical distributions of training data
predictors between benign and malignant tumour masses.

</p>

</div>

We chose to use a simple classification model using the k-nearest
neighbours algorithm. To find the model that best predicted whether a
tumour was benign or malignant, we performed 30-fold cross validation
using Cohen’s Kappa as our metric of model prediction performance to
select K (number of nearest neighbours). We observed that the optimal K
was
5.

<div class="figure">

<img src="../results/kappa_vs_k.png" alt="Figure 2. Results from 30-fold cross validation to choose K. Cohen's Kappa was used as the classification metric as K was varied." width="60%" />

<p class="caption">

Figure 2. Results from 30-fold cross validation to choose K. Cohen’s
Kappa was used as the classification metric as K was varied.

</p>

</div>

Our prediction model performed quite well on test data, with a final
Cohen’s Kappa score of 0.9 and an overall accuracy calculated to be
0.97. Other indicators that our model performed well come from the
confusion matrix, where it only made 4 mistakes. However all 4 mistakes
were predicting a malignant tumour as benign, given the implications
this has for patients health, this model is not good enough to yet
implement in the
clinic.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

Table 1. Confusion matrix of model performance on test
data.

</caption>

<thead>

<tr>

<th style="border-bottom:hidden" colspan="1">

</th>

<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2">

<div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">

Reference

</div>

</th>

</tr>

<tr>

<th style="text-align:left;">

</th>

<th style="text-align:right;">

B

</th>

<th style="text-align:right;">

M

</th>

</tr>

</thead>

<tbody>

<tr grouplength="2">

<td colspan="3" style="border-bottom: 1px solid;">

<strong>Predicted</strong>

</td>

</tr>

<tr>

<td style="text-align:left; padding-left: 2em;" indentlevel="1">

B

</td>

<td style="text-align:right;">

89

</td>

<td style="text-align:right;">

4

</td>

</tr>

<tr>

<td style="text-align:left; padding-left: 2em;" indentlevel="1">

M

</td>

<td style="text-align:right;">

0

</td>

<td style="text-align:right;">

49

</td>

</tr>

</tbody>

</table>

To further improve this model in future with hopes of arriving one that
could be used in the clinic, there are several things we can suggest.
First, we could look closely at the 4 misclassified observations and
compare them to several observations that were classified correctly
(from both classes). The goal of this would be to see which feature(s)
may be driving the misclassification and explore whether any feature
engineering could be used to help the model better predict on
observations that it currently is making mistakes on. Additionally, we
would try seeing whether we can get improved predictions using other
classifiers. One classifier we might try is random forest forest because
it automatically allows for feature interaction, where k-nn does not.
Finally, we also might improve the usability of the model in the clinic
if we output and report the probability estimates for predictions. If we
cannot prevent misclassifications through the approaches suggested
above, at least reporting a probability estimates for predictions would
allow the clinician to know how confident the model was in its
prediction. Thus the clinician may then have the ability to perform
additional diagnostic assays if the probability estimates for prediction
of a given tumour class is not very high.

# References

<div id="refs" class="references">

<div id="ref-ccsac">

Canadian Cancer Statistics Advisory Committee. 2019. “Canadian Cancer
Statistics.” *Canadian Cancer Society*.
<http://cancer.ca/Canadian-Cancer-Statistics-2019-EN>.

</div>

<div id="ref-docopt">

de Jonge, Edwin. 2018. *Docopt: Command-Line Interface Specification
Language*. <https://CRAN.R-project.org/package=docopt>.

</div>

<div id="ref-Dua2019">

Dua, Dheeru, and Casey Graff. 2017. “UCI Machine Learning Repository.”
University of California, Irvine, School of Information; Computer
Sciences. <http://archive.ics.uci.edu/ml>.

</div>

<div id="ref-caret">

Jed Wing, Max Kuhn. Contributions from, Steve Weston, Andre Williams,
Chris Keefer, Allan Engelhardt, Tony Cooper, Zachary Mayer, et al. 2019.
*Caret: Classification and Regression Training*.
<https://CRAN.R-project.org/package=caret>.

</div>

<div id="ref-docoptpython">

Keleshev, Vladimir. 2014. *Docopt: Command-Line Interface Description
Language*. <https://github.com/docopt/docopt>.

</div>

<div id="ref-mckinney-proc-scipy-2010">

McKinney, Wes. 2010. “Data Structures for Statistical Computing in
Python.” In *Proceedings of the 9th Python in Science Conference*,
edited by Stéfan van der Walt and Jarrod Millman, 51–56.

</div>

<div id="ref-featherpy">

———. 2019. *Feather: Simple Wrapper Library to the Apache Arrow-Based
Feather File Format*. <https://github.com/wesm/feather>.

</div>

<div id="ref-R">

R Core Team. 2019. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-Streetetal">

Street, W. Nick, W. H. Wolberg, and O. L. Mangasarian. 1993. “Nuclear
feature extraction for breast tumor diagnosis.” In *Biomedical Image
Processing and Biomedical Visualization*, edited by Raj S. Acharya and
Dmitry B. Goldgof, 1905:861–70. International Society for Optics;
Photonics; SPIE. <https://doi.org/10.1117/12.148698>.

</div>

<div id="ref-Python">

Van Rossum, Guido, and Fred L. Drake. 2009. *Python 3 Reference Manual*.
Scotts Valley, CA: CreateSpace.

</div>

<div id="ref-tidyverse">

Wickham, Hadley. 2017. *Tidyverse: Easily Install and Load the
’Tidyverse’*. <https://CRAN.R-project.org/package=tidyverse>.

</div>

<div id="ref-featherr">

———. 2019. *Feather: R Bindings to the Feather ’Api’*.
<https://CRAN.R-project.org/package=feather>.

</div>

<div id="ref-knitr">

Xie, Yihui. 2014. “Knitr: A Comprehensive Tool for Reproducible Research
in R.” In *Implementing Reproducible Computational Research*, edited by
Victoria Stodden, Friedrich Leisch, and Roger D. Peng. Chapman;
Hall/CRC. <http://www.crcpress.com/product/isbn/9781466561595>.

</div>

</div>
