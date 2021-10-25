# Breast Cancer Predictor

  - author: Tiffany Timbers
  - contributors: Melissa Lee

Demo of a data analysis project for DSCI 522 (Data Science workflows); a
course in the Master of Data Science program at the University of
British Columbia.

## About

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

The data set that was used in this project is of digitized breast cancer
image features created by Dr. William H. Wolberg, W. Nick Street, and
Olvi L. Mangasarian at the University of Wisconsin, Madison (Street,
Wolberg, and Mangasarian 1993). It was sourced from the UCI Machine
Learning Repository (Dua and Graff 2017) and can be found
[here](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+\(Diagnostic\)),
specifically [this
file](http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data).
Each row in the data set represents summary statistics from measurements
of an image of a tumour sample, including the diagnosis (benign or
malignant) and several other measurements (e.g., nucleus texture,
perimeter, area, etc.). Diagnosis for each image was conducted by
physicians.

## Report

The final report can be found
[here](https://ttimbers.github.io/breast_cancer_predictor/doc/breast_cancer_predict_report.html).

## Usage

There are two suggested ways to run this analysis:

#### 1\. Using Docker

*note - the instructions in this section also depends on running this in
a unix shell (e.g., terminal or Git Bash)*

To replicate the analysis, install
[Docker](https://www.docker.com/get-started). Then clone this GitHub
repository and run the following command at the command line/terminal
from the root directory of this project:

```bash
    docker run --rm -v /$(pwd):/home/rstudio/breast_cancer_predictor ttimbers/bc_predictor:v4.0 make -C /home/rstudio/breast_cancer_predictor all
```
To reset the repo to a clean state, with no intermediate or results
files, run the following command at the command line/terminal from the
root directory of this project:

```bash
    docker run --rm -v /$(pwd):/home/rstudio/breast_cancer_predictor ttimbers/bc_predictor:v4.0 make -C /home/rstudio/breast_cancer_predictor clean
```

**Note: If you are using Git Bash on Windows, the paths should be written with two forward slashes `//`. In this case you should type:***

```bash
    docker run --rm -v /$(pwd)://home//rstudio//breast_cancer_predictor ttimbers/bc_predictor:v4.0 make -C //home//rstudio//breast_cancer_predictor all
```
**and to the reset the repo to a clean state**

```bash
    docker run --rm -v /$(pwd)://home//rstudio//breast_cancer_predictor ttimbers/bc_predictor:v4.0 make -C //home//rstudio//breast_cancer_predictor clean
```
#### 2\. Without using Docker

To replicate the analysis, clone this GitHub repository, install the
[dependencies](#dependencies) listed below, and run the following
command at the command line/terminal from the root directory of this
project:

    make all

To reset the repo to a clean state, with no intermediate or results
files, run the following command at the command line/terminal from the
root directory of this project:

    make clean

## Dependencies

  - Python 3.7.4 and Python packages:
      - docopt=0.6.2
      - requests=2.22.0
      - pandas=0.25.1R
      - feather-format=0.4.0
  - R version 3.6.1 and R packages:
      - knitr=1.26
      - feather=0.3.5
      - tidyverse=1.3.0
      - caret=6.0-85
      - ggridges=0.5.2
      - ggthemes=4.2.0
  - GNU make 4.2.1

## License

The Breast Cancer Predictor materials here are licensed under the
Creative Commons Attribution 2.5 Canada License (CC BY 2.5 CA). If
re-using/re-mixing please provide attribution and link to this webpage.

# References

<div id="refs" class="references hanging-indent">

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
