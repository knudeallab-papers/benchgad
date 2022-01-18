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
pg_dataset <- filter(dataset, DBMS=="PG-Strom")
bz_dataset <- filter(dataset, DBMS=="BlazingSQL")
om_dataset <- filter(dataset, DBMS=="OmniSci")

dataset <- rbind(pg_dataset, bz_dataset) %>% rbind(om_dataset)

### descriptive statistics ####
ShowStat(dataset)

preprocessed_dataset <- preprocessing(dataset)
preprocessed_dataset$MG

blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)

pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)

omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)

entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)


### Section 5.2 Correlation Analysis
## H1a 
test <- as.data.frame(cbind(X=entire_dataset$MG, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H1b 
test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H1c 
test <- as.data.frame(cbind(X=entire_dataset$CC, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H1d

test <- as.data.frame(cbind(X=entire_dataset$RAM_Size, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res


## H1e

test <- as.data.frame(cbind(X=entire_dataset$GM, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H2a
test <- as.data.frame(cbind(X=entire_dataset$NumJoins, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H2b
test <- as.data.frame(cbind(X=entire_dataset$NumAllAtts, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H2c
test <- as.data.frame(cbind(X=entire_dataset$SQ, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res


## H3a
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H3b
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$PF))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H3c
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res


## H3d
test <- as.data.frame(cbind(X=entire_dataset$DB_Size, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H4a
test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$NumIK))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H4b
test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$KT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

## H4c
test <- as.data.frame(cbind(X=entire_dataset$PF, Y=entire_dataset$DT))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

# H5a
test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

# H5b
test <- as.data.frame(cbind(X=entire_dataset$DT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res

### Section 5.3 Regression Analysis
## A fit for Elapsed time
fit_et = lm(ET ~ DT + KT, data = entire_dataset) 
summary(fit_et) 

## A fit for Kernel execution time 
fit_kt = lm(KT ~ MG + CC + PF + DB_Size, data = entire_dataset)
summary(fit_kt) 

## A fit for Number of page faults  
fit_pf = lm(PF ~ RAM_Size + GM +  NumIK + DB_Size, data = entire_dataset)   
summary(fit_pf)

## A fit for Number of invoked kernels 
fit_nik = lm(NumIK ~ NumJoins + NumAllAtts + SQ + DB_Size, data = entire_dataset)
summary(fit_nik) 

## A fit for Data transfer time  
fit_dt = lm(DT ~ GM + PF + DB_Size , data = entire_dataset) 
summary(fit_dt) 
