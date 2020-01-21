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
set.seed(2020)

opt <- docopt(doc)

main <- function(train, out_dir) {

  # Tune hyperparameters ----------------------------------------------------

  train_data <- read_feather(train) 
  x_train <- train_data %>% 
    select(-class)
  y_train <- train_data %>% 
    select(class) %>% 
    mutate(class = as.factor(class)) %>% 
    pull()
  k = data.frame(k = seq(1, 200, by = 2))
  cross_val <- trainControl(method="cv", number = 30)
  model_cv_30fold <- train(x = x_train, y = y_train, method = "knn", tuneGrid = k, trControl = cross_val)
  
  # Visualize accuracy for K's ----------------------------------------------

  accuracy_vs_k <- model_cv_30fold$results %>% 
    ggplot(aes(x = k, y = Accuracy)) +
      geom_point() +
      xlab("30-fold cross-validation accuracy")
  try({
    dir.create(out_dir)
  })
  ggsave(paste0(out_dir, "/accuracy_vs_k.png"), width = 4, height = 4)
  
  # Fit final model ---------------------------------------------------------
  best_k <- model_cv_30fold$result %>% 
    filter(Accuracy == max(Accuracy)) %>% 
    select(k) %>% 
    pull()
  final_model <- train(x = x_train, y = y_train, method = "knn", tuneGrid = data.frame(k = best_k))
  saveRDS(final_model, file = paste0(out_dir, "/final_model.rds"))
}
  
main(opt[["--train"]], opt[["--out_dir"]])
  