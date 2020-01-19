# Breast Cancer Predictor
- author: Tiffany Timbers
- contributors: Melissa Lee

Demo of a data analysis project for DSCI 522 (Data Science workflows); a course in the Master of Data Science program at the University of British Columbia.

## Introduction



## Usage

To replicate the analysis, clone this GitHub repository, install the [dependencies](#dependencies) listed below, and run the following commands at the command line/terminal from the root directory of this project:

```
python src/download_data.py --out_type=feather --url=http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data --out_file=data/raw/wdbc.feather
Rscript -e "rmarkdown::render('src/breast_cancer_eda.Rmd')"
```

## Dependencies
- Python 3.7.3 and Python packages:
  - docopt==0.6.2
  - requests==2.22.0
  - pandas==0.24.2
  - feather-format==0.4.0
- R version 3.6.1 and R packages:
  - knitr==1.26
  - feather==0.3.5
  - tidyverse==1.2.1
  - caret==6.0-84
  - ggridges==0.5.1
  - ggthemes==4.2.0