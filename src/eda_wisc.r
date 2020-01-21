# author: Tiffany Timbers
# date: 2019-12-28

"Creates eda plots for the pre-processed training data from the Wisconsin breast cancer data (from http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data).
Saves the plots as a pdf and png file.

Usage: src/eda_wisc.r --train=<train> --out_dir=<out_dir>
  
Options:
--train=<train>     Path (including filename) to training data (which needs to be saved as a feather file)
--out_dir=<out_dir> Path to directory where the plots should be saved
" -> doc

library(feather)
library(tidyverse)
library(caret)
library(docopt)
set.seed(2020)

opt <- docopt(doc)

main <- function(train, out_dir) {
  train_data <- read_feather(train) %>% 
    gather(key = predictor, value = value, -class) %>% 
    ggplot(aes(x = value, fill = class)) +
      geom_histogram() +
      facet_wrap(. ~ predictor, nrow = 5)
  ggsave(paste0(out_dir, "/predictor_distributions_across_class.png"), 
         train_data,
         width = 6, 
         height = 8)
}
main(opt[["--train"]], opt[["--out_dir"]])