# author: Tiffany Timbers
# date: 2019-12-29

"Assesses model's accuracy on a test data set.

Usage: src/breast_cancer_test.py --test=<test> --out_dir=<out_dir>

Options:
--test=<test>          Path (including filename) to test data (which needs to be saved as a feather file)
--out_dir=<out_dir>    Path to directory where the plots should be saved
" -> doc
  
library(feather)
library(tidyverse)
library(caret)
library(docopt)
set.seed(2020)

opt <- docopt(doc)

main <- function(test, out_dir) {

  # Load and wrangle test data ----------------------------------------------
  test_data <- read_feather(test) 
  x_test <- test_data %>% 
    select(-class)
  y_test <- test_data %>% 
    select(class) %>% 
    mutate(class = as.factor(class)) %>% 
    pull()
  
  # Load model and predict --------------------------------------------------
  final_model <- readRDS("results/final_model.rds")
  y_pred <- predict(final_model, x_test)
  
  # assess model accuracy ---------------------------------------------------
  model_quality <- confusionMatrix(y_pred, y_test)
  saveRDS(model_quality, file = paste0(out_dir, "/final_model_quality.rds"))
}
  
main(opt[["--test"]], opt[["--out_dir"]])