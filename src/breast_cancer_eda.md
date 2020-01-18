Exploratory data analysis of the Wisconsin Breast Cancer data set
================

## Summary of the data set

    ## Warning: Coercing int64 to double

The data set used in this project is of [digitized breast cancer image
features](http://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29),
created by Dr. William H. Wolberg, W. Nick Street, and Olvi L.
Mangasarian at the University of Wisconsin, Madison. Each row in the
data set represents an image of a tumour sample, including the diagnosis
(benign or malignant) and several other measurements (e.g., nucleus
texture, perimeter, area, etc.). Diagnosis for each image was conducted
by physicians. There are 569 observations in the data set, and 31
features. There are 0 observations with missing values in the data set.
Below we show the number of each observations for each of the classes in
the data set.

| benign cases | malignant cases |
| -----------: | --------------: |
|          357 |             212 |

Table 1. Counts of observation for each class.

## Split into training and test data set

Before proceeding further, we will split the data such that 75% of
observations are in the training and 25% of observations are in the test
set. Below we list the counts of observations:

## Exploratory analysis on the training data set
