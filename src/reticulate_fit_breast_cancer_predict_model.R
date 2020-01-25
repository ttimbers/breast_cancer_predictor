# Tiffany Timbers
# 2020-01-25

# import R libraries
library(tidyverse)
library(feather)
library(reticulate)
set.seed(2019)

# import python libraries
sklearn_neighbours <- import("sklearn.neighbors")
sklearn_model_selection <- import("sklearn.model_selection")
sklearn_metrics <- import("sklearn.metrics")
#from sklearn.metrics import cohen_kappa_score, make_scorer



# load training data as an R data frame
train_data <- read_feather("data/processed/training.feather") %>% 
  mutate(class = as.integer(as.factor(class)) )

# create X and Y
X_train <- train_data %>% 
  select(-class)
y_train <- train_data %>% 
  select(class) %>% 
  pull(class) %>% 
  as.factor() %>% 
  as.integer()
y_train <- Y_train - 1

# create a knn model object
knn_model <- sklearn_neighbours$KNeighborsClassifier()



kappa_scorer <- sklearn_metrics$make_scorer(sklearn_metrics$cohen_kappa_score)

# grid search over k
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

ggplot(cv_results, aes(x = k, y = cv_mean)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = cv_mean - cv_se, ymax = cv_mean + cv_se)) +
  xlab("K") +
  ylab("Average Cohen's Kappa \n (30-fold cross-validation)") 
  
# # or using grid search
# # create a python dictionary of k's to search over
#np <- import("numpy")
# k_grid <- dict(n_neighbors = np$arange(1, 25))
# knn_gscv = sklearn_model_selection$GridSearchCV(knn_model, k_grid, cv=5L)
# knn_cv_results <- knn_gscv$fit(X_train, y_train)
# # get best k
# print(knn_cv_results$best_estimator_)

  #model_fit <- model$fit(bc_data, bc_data[[2]])
# from sklearn.model_selection import GridSearchCV
# #create new a knn model
# knn2 = KNeighborsClassifier()
# #create a dictionary of all values we want to test for n_neighbors
# param_grid = {‘n_neighbors’: np$arange(1, 25)}
# #use gridsearch to test all values for n_neighbors
# knn_gscv = GridSearchCV(knn2, param_grid, cv=5)
# #fit model to data
# knn_gscv.fit(X, y)
# 
# 
# 
# # 
# model <- sklearn$KNeighborsClassifier(n_neighbors=3L)
# 
# model_fit <- model$fit(bc_data, bc_data[[2]])