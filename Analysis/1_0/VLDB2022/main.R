library(dplyr)
library(pastecs)
library(ggplot2)
RowName="Row_No"
full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'CC', 'QNo','AGG',
                  'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                  'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET','DT')

nontime_feature <- c('RAM_Size','DB_Size', 'CC', 'NumJoins','NumFTAtts', 'NumAllAtts', 'NumAllTbl', 'NumDsTbl','NumIK')
time_feature <- c('HDT','DHT','KT','ET','DT')

folder <- '.'
setwd(folder)
source(paste0(folder, "/ReArrange.R"), echo=TRUE)
source(paste0(folder, "/ShowStat.R"), echo=TRUE)

dataset <- read.csv(file=paste0(folder, '/raw_dataset.csv'), header = TRUE,stringsAsFactors = FALSE)
## data transfer time 
pg_dataset <- filter(dataset, DBMS=="PG-Strom")
bz_dataset <- filter(dataset, DBMS=="BlazingSQL")
om_dataset <- filter(dataset, DBMS=="OmniSci")

dataset <- rbind(pg_dataset, bz_dataset) %>% rbind(om_dataset)

### descriptive statistics ####
ShowStat(dataset)

preprocessed_dataset <- preprocessing(dataset)
#nrow(preprocessed_dataset)

blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)

pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)

omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)

entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)

#
test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$BS, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

