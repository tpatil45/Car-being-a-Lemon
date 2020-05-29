 

setwd("C:/Users/bhavi/OneDrive/Desktop/SYR ADS/Sem 2/IST_707_Data_Analytics/Project")


perf_knn <- read.csv("df_KNN.csv")
perf_knn[perf_knn$K==21,]

perf_rf <- read.csv("df_RF.csv")
colnames(perf_rf) <- c("NUMBER_of_TREES","NUMBER_of_FEATURES","ACCURACY","RECALL","AUC")
perf_rf


perf_gb <- read.csv("df_GBM.csv")
colnames(perf_gb) <- c("NUMBER_of_TREES","MAX_DEPTH","LEARNING_RATE","MIN_SAMPLES_LEAF","ACCURACY","RECALL","AUC")
perf_gb


gbm_model <- readRDS(file = "Gradient_Model.Rda")

test_df <- read.csv("Balanced_Test.csv")
train_df <- read.csv("Balanced_Train.csv")

new_testing <- test_df[1:4,1:8]

predict(gbm_model, newdata = train_df)

sessionInfo()

rules_mat <- readRDS(file = "rules_mat.Rda")


#### BUILDING MINIMIZED MODELS for DASHBOARD
install.packages("DMwR")
library(DMwR)
library(caret)

str(car_buy_clean_df)

car_buy_clean_minimzed_df <- car_buy_clean_df[,c("IsBadBuy","VehicleAge","Transmission","WheelType","VehOdo","VehBCost",
                                                 "MMRAcqAucAvgPrice","MMRAcqAucCleanPrice","MMRCurrAucAvgPrice","MMRCurrAucCleanPrice")]

train_index <- createDataPartition(car_buy_clean_minimzed_df$IsBadBuy, p = 0.8, list = FALSE)

car_buy_clean_minimzed_train_df <- car_buy_clean_minimzed_df[train_index, ]

car_buy_clean_minimzed_test_df <- car_buy_clean_minimzed_df[-train_index, ]

set.seed(9)
car_buy_clean_minimzed_train_smote_df <- SMOTE(IsBadBuy~., car_buy_clean_minimzed_train_df, perc.under = 10300, perc.over= 1)

### RANDOM FOREST MODEL

rf_model_minimized_dashb <- train(IsBadBuy ~ ., data = car_buy_clean_minimzed_train_smote_df, method = "rf")

predict_rf_dashb <- predict(rf_model_minimized_dashb, newdata = car_buy_clean_minimzed_test_df)

confusionMatrix(predict_rf_dashb,car_buy_clean_minimzed_test_df$IsBadBuy, positive = "1")

### GRADIENT BOOSTING MODEL

gb_model_minimized_dashb <- train(IsBadBuy ~ ., data = car_buy_clean_minimzed_train_smote_df, method = "gbm")

predict_gb_dashb <- predict(gb_model_minimized_dashb, newdata = car_buy_clean_minimzed_test_df)
confusionMatrix(predict_gb_dashb,car_buy_clean_minimzed_test_df$IsBadBuy, positive = "1")

car_buy_clean_minimzed_test_df$predict_gb_dashb <- predict_gb_dashb
car_buy_clean_minimzed_test_df$predict_rf_dashb <- predict_rf_dashb

summary(car_buy_clean_minimzed_test_df)

str(car_buy_clean_minimzed_test_df)

predict_gb_dashb[predict_gb_dashb=="1"]

predict(rf_model_minimized_dashb, newdata = car_buy_clean_minimzed_test_df[,2:10])


pca_plot <- readRDS(file = "Cumulative_PCAR.Rda")
pca_plot

remove(pca_plot)
