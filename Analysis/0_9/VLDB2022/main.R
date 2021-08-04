library(dplyr)
library(pastecs)
library(ggplot2)

folder <- '.'
setwd(folder)
source(paste0(folder, "/ReArrange.R"), echo=TRUE)

dataset <- read.csv(file=paste0(folder, '/raw_dataset.csv'), header = TRUE,stringsAsFactors = FALSE)

preprocessed_dataset <- preprocessing(dataset)

RowName="Row_No"
full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'BS', 'QNo','AGG',
                      'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                      'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET')

nontime_feature <- c('RAM_Size','DB_Size', 'BS', 'NumJoins','NumFTAtts', 'NumAllAtts', 'NumAllTbl', 'NumDsTbl','NumIK')
time_feature <- c('HDT','DHT','KT','ET')

blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)

pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)

omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)

entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)

#
test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$BS, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$HDT))
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

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$HDT))
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

test <- as.data.frame(cbind(X=entire_dataset$HDT, Y=entire_dataset$ET))
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

#names(test) <- c('KT','ET')
test <- as.data.frame(cbind(KT=entire_dataset$KT, ET=entire_dataset$ET))
res <- cor.test(test$KT,test$ET, 
                    method = "pearson")

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$HDT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

## Number of GPU Cards
test <- as.data.frame(cbind(X=entire_dataset$MG, Y=(entire_dataset$HDT)))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res


## Amount of Host Memory 
test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res


# Amount of Device Memory
test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

## GPU Generation 
test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res


## Number of Joins
test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Number of all attributes 
test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Presence of Subquery 
test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Scale of Data Volume
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$HDT))
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

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Scale of Data Volume
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$HDT))
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

test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Data Transfer Time
test <- as.data.frame(cbind(X=entire_dataset$HDT), Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$HDT), Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$HDT), Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$HDT), Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res


# Page Faults
test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$PF))
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

test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Number of Kernels Invoked
test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Number of Kernel Time
test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$HDT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res