# author: Tiffany Timbers
# date: 2019-12-28

"Fits a k-nn model on the pre-processed training data from the Wisconsin breast cancer data (from http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data).
Saves the model as a rds file.

Usage: src/fit_breast_cancer_predict_model.r --train=<train> --out_dir=<out_dir>
  
Options:
--train=<train>     Path (including filename) to training data (which needs to be saved as a feather file)
--out_dir=<out_dir> Path to directory where the serialized model should be written
" -> doc

library(feather)
library(tidyverse)
library(caret)
library(docopt)
set.seed(2019)

opt <- docopt(doc)
train <- "data/processed/training.feather"
out_dir <- "results"

main <- function(train, out_dir) {

  # Tune hyperparameters ----------------------------------------------------

  train_data <- read_feather(train) 
  x_train <- train_data %>% 
    select(-class, -se_fractal_dimension, -se_smoothness, -se_symmetry, -se_texture)
  y_train <- train_data %>% 
    select(class) %>% 
    mutate(class = as.factor(class)) %>% 
    pull()
  k = data.frame(k = seq(1, 100, by = 2))
  cross_val <- trainControl(method="cv", number = 30)
  model_cv_30fold <- train(x = x_train, y = y_train, method = "knn", 
                           metric = "Kappa", tuneGrid = k, trControl = cross_val)
  
  # Visualize kappa for K's ----------------------------------------------

  kappa_vs_k <- model_cv_30fold$results %>% 
    ggplot(aes(x = k, y = Kappa)) +
      geom_point() +
      geom_errorbar(aes(ymin = Kappa - (KappaSD/sqrt(30)), ymax = Kappa + (KappaSD/sqrt(30)))) +
      xlab("K") +
      ylab("Average Cohen's Kappa \n (30-fold cross-validation)") 
  try({
    dir.create(out_dir)
  })
  ggsave(paste0(out_dir, "/kappa_vs_k.png"), width = 5, height = 3)
  
  # Fit final model ---------------------------------------------------------
  final_model <- train(x = x_train, y = y_train, method = "knn", 
                       tuneGrid = data.frame(k = model_cv_30fold$bestTune$k))
  saveRDS(final_model, file = paste0(out_dir, "/final_model.rds"))
}
  
main(opt[["--train"]], opt[["--out_dir"]])
  