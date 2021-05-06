library(dplyr)
library(pastecs)
library(ggplot2)

folder <- '.'
setwd(folder)
source(paste0(folder, "/ReArrange.R"), echo=TRUE)

dataset <- read.csv(file=paste0(folder, '/raw_dataset.csv'), header = TRUE,stringsAsFactors = FALSE)

preprocessed_dataset <- preprocessing(dataset)

RowName="Row_No"
full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'QNo','AGG',
                      'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                      'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET')

nontime_feature <- c('RAM_Size','DB_Size','NumJoins','NumFTAtts', 'NumAllAtts', 'NumAllTbl', 'NumDsTbl','NumIK')
time_feature <- c('HDT','DHT','KT','ET')

blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)

pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)

omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)

entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)

#test <- cbind(KT=entire_dataset$KT,ET=entire_dataset$ET)
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

test <- as.data.frame(cbind(X=(entire_dataset$HDT+entire_dataset$DHT)/2, Y=entire_dataset$ET))
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

#full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'QNo','AGG',
#                      'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
#                      'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET')
## Number of GPU Cards
test <- as.data.frame(cbind(X=entire_dataset$MG, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$GM, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$Gen, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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

test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

# Number of all attributes 
test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=(entire_dataset$HDT+entire_dataset$DHT)/2), Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=(entire_dataset$HDT+entire_dataset$DHT)/2), Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=(entire_dataset$HDT+entire_dataset$DHT)/2), Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res

test <- as.data.frame(cbind(X=(entire_dataset$HDT+entire_dataset$DHT)/2), Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                    method = "pearson")
res


# Page Faults
test <- as.data.frame(cbind(X=entire_dataset$PF, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$NumIK, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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
test <- as.data.frame(cbind(X=entire_dataset$KT, Y=(entire_dataset$HDT+entire_dataset$DHT)/2))
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

library("ggpubr")
ggscatter(my_data, x = "mpg", y = "wt", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")


# Shapiro-Wilk normality test for mpg
#shapiro.test(my_data$mpg) # => p = 0.1229
shapiro.test(entire_dataset$KT) # => p = 0.1229
# Shapiro-Wilk normality test for wt
#shapiro.test(my_data$wt) # => p = 0.09
shapiro.test(entire_dataset$ET)

#http://www.sthda.com/english/wiki/correlation-test-between-two-variables-in-r#:~:text=Pearson%20correlation%20(r)%2C%20which,y%20are%20from%20normal%20distribution.
library("ggpubr")
ggqqplot(entire_dataset$KT, ylab = "Kernel Time")
ggqqplot(entire_dataset$ET, ylab = "Elapsed Time")
res <- cor.test(entire_dataset$KT,entire_dataset$ET, 
                    method = "pearson")
res

res2 <- cor.test(entire_dataset$KT, entire_dataset$ET,  method="kendall")
res2

res2 <-cor.test(entire_dataset$KT, entire_dataset$ET,  method = "spearman")
res2


# PG-Strom DB > 8 not contained Entire Dataframe
entire_dataset_withoutPGdb8 <- bind_rows(blazingsql, pgstrom_withoutDB8) %>% bind_rows(omnisci)

# Outlier count
#trimpoints <- Make_Trimpoints(100,99,0.1)
#outlier_check <- OutlierCount(entire_dataset, features, trimpoints)

#outlier_check

# trimming samples that became outliers out of 4 or more columnstlier_trimmed_dataset <- Trim_Outlier(entire_dataset, features, 99.9)


# ????correlationr <- Correlation(outlier_trimmed_dataset)

#fname <- 'correlation'
#write.csv(corr, file=paste0(fname, '.csv'), row.names = T)




