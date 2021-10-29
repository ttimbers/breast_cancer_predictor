# Tiffany Timbers
# 2020-01-25

"Fits a k-nn model on the pre-processed training data from the Wisconsin breast cancer data (from http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data) 
Saves the model as a rds file. Uses sklearn to fit classifier.

Usage: src/fit_breast_cancer_predict_model.r --train=<train> --out_dir=<out_dir>
  
Options:
--train=<train>     Path (including filename) to training data (which needs to be saved as a feather file)
--out_dir=<out_dir> Path to directory where the serialized model should be written
" -> doc

# import R libraries
library(tidyverse)
library(feather)
library(reticulate)
library(docopt)
set.seed(2019)

# import python libraries
sklearn_neighbours <- import("sklearn.neighbors")
sklearn_model_selection <- import("sklearn.model_selection")
sklearn_metrics <- import("sklearn.metrics")

opt <- docopt(doc)

main <- function(train, out_dir) {
  
  # Load and wrangle data ---------------------------------------------------
  
  # load training data as an R data frame
  train_data <- read_feather("data/processed/training.feather") |> 
    mutate(class = as.integer(as.factor(class)) )
  
  # create X and Y
  X_train <- train_data |> 
    select(-class)
  y_train <- train_data  |>  
    select(class) |> 
    pull(class) |> 
    as.factor() |> 
    as.integer()
  y_train <- y_train - 1
  
  # Tune hyperparameters ----------------------------------------------------
  
  # create a knn model object
  knn_model <- sklearn_neighbours$KNeighborsClassifier()
  
  # grid search over k using Cohen's kappa
  kappa_scorer <- sklearn_metrics$make_scorer(sklearn_metrics$cohen_kappa_score)
  folds <- 30L
  max_k <- 100
  k <- c(1:max_k)
  cv_mean <- c(rep(NA, max_k))
  cv_se <- c(rep(NA, max_k))
  for (i in seq_along(k)) {
    knn_model <- sklearn_neighbours$KNeighborsClassifier(n_neighbors = i)
    knn_model_cv <- sklearn_model_selection$cross_val_score(knn_model, X_train, y_train, cv = folds, scoring = kappa_scorer)
    cv_mean[i] <- mean(knn_model_cv)
    cv_se[i] <- sd(knn_model_cv) / sqrt(folds)
  }
  cv_results <- tibble(k = k, cv_mean = cv_mean, cv_se = cv_se)
  
  # Visualize kappa for K's ----------------------------------------------
  kappa_vs_k <- ggplot(cv_results, aes(x = k, y = cv_mean)) +
    geom_point() +
    geom_line() +
    geom_errorbar(aes(ymin = cv_mean - cv_se, ymax = cv_mean + cv_se)) +
    xlab("K") +
    ylab("Average Cohen's Kappa \n (30-fold cross-validation)") 
  
  try({
    dir.create(out_dir)
  })
  ggsave(paste0(out_dir, "/kappa_vs_k.png"), kappa_vs_k, width = 5, height = 3)
  
  # Fit final model ---------------------------------------------------------
  best_k <- cv_results |> 
    filter(cv_mean == max(cv_mean)) |> 
    select(k) |> 
    pull() |>
    as.integer()
  knn_final_model <- sklearn_neighbours$KNeighborsClassifier(n_neighbors = best_k)
  knn_final_model_fit <- knn_final_model$fit(X_train, y_train)
  py_save_object(knn_final_model_fit, paste0(out_dir, "/final_model.pickle"), pickle = "pickle")
}

main(opt[["--train"]], opt[["--out_dir"]])
