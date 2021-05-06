library(dplyr)
library(pastecs)
library(ggplot2)
library(caret)
#install.packages("caret")



#쿼리 전처리 
query_preprocessing <- function(dataset){
  
  dataset <- na.omit(dataset)
  dataset[, c('X..of.kernels.invoked','GPU.utilization.Kernel.Time.')] <- lapply(dataset[, 
                                                                                         c('X..of.kernels.invoked','GPU.utilization.Kernel.Time.')], as.numeric)
  
  kerneldataset <- dataset[c(2,8, 21, 22)]
  names(kerneldataset) <- c('DBMS', 'Query.Name','Num. of Kern.Inv', 'Kernel Exec.Time')
  
  return(kerneldataset)
}

# 그래프 
Graph <- function(agg, feature, dbmsname){
  
  agg <- agg[c(1,11,14:20,2:10,12:13),]
  
  if(feature=='mean_kernelInv'){
    min_ = min(floor(agg$'mean_kernelInv'))
    max_ = max(ceiling(agg$'mean_kernelInv'))
    features = agg$'mean_kernelInv'
  }else{
    if(dbmsname=='Entire'){
      min_=0
      max_=0.1
    }else{
      min_ = min(floor(agg$'mean_kernelTime'))  
      max_ = max(ceiling(agg$'mean_kernelTime'))
    }
    features = agg$'mean_kernelTime'
  }
  
  query=agg$Query.Name
  
  plot(features, type='o', col=1, ylim=c(min_, max_), axes=FALSE, xlab='Query Name', ylab='Samples',
       main = paste(dbmsname, feature, sep=" "))
  axis(1,at=1:length(query), lab=query, lty=1, lwd=0.8)
  axis(2, ylim=c(min_, max_))
}

# 세 DBMS plot
EntirePlot <- function(bla, pg, om, entire, feature){
  
  bla <- bla[c(1,11,14:20,2:10,12:13),]
  pg <- pg[c(1,11,14:20,2:10,12:13),] 
  om <- om[c(1,11,14:20,2:10,12:13),]
  entire <- entire[c(1,11,14:20,2:10,12:13),]
  names=c('Entire', 'BlazingSQL', 'PG-Strom', 'OmniSci')
  
  query=bla$Query.Name
  
  if(feature=='mean_kernelInv'){
    plot(entire$'mean_kernelInv', type='o', col=1, ylim=c(0,1), axes=FALSE,xlab='Query Name', ylab='Samples',
         main =paste('Total', feature, sep=" ") )
    lines(bla$'mean_kernelInv', type='o', col=2)
    lines(pg$'mean_kernelInv', type='o', col=3)
    lines(om$'mean_kernelInv', type='o', col=4)
    
    axis(1,at=1:length(query), lab=query, lty=1, lwd=0.8)
    axis(2, ylim=c(0, 1))
    legend(17, 1, names, cex=0.7, pch=1, col=1:length(names), lty = 1)
  }else{
    plot(entire$'mean_kernelTime', type='o', col=1, ylim=c(0,0.2), axes=FALSE, xlab='Query Name', ylab='Samples',
         main = paste('Total', feature, sep=" "))
    lines(bla$'mean_kernelTime', type='o', col=2)
    lines(pg$'mean_kernelTime', type='o', col=3)
    lines(om$'mean_kernelTime', type='o', col=4)
    
    axis(1,at=1:length(query), lab=query, lty=1, lwd=0.8)
    axis(2, ylim=c(0, 0.2))
    legend(3, 0.2, names, cex=0.7, pch=1, col=1:length(names), lty = 1)
  }
}


#각 쿼리에 대해, DBMS별로 log transformation
LogTransformByQuery <- function(dataset){
  
  Query=c('Q1', 'Q2','Q3','Q4','Q5','Q6','Q7','Q8','Q9','Q10','Q11','Q12','Q13','Q14',
          'Q15','Q16','Q17','Q18','Q19','Q20','Q21','Q22')
  dbms=c('BlazingSQL', 'PG-Strom', 'OmniSci')
  
  for(query in Query){
    for(db in dbms){
      dataset[(dataset$Query.Name==query)&(dataset$DBMS==db), 'Num. of Kern.Inv']=log1p(
        dataset[(dataset$Query.Name==query)&(dataset$DBMS==db), 'Num. of Kern.Inv'])
      dataset[(dataset$Query.Name==query)&(dataset$DBMS==db), 'Kernel Exec.Time']=log1p(
        dataset[(dataset$Query.Name==query)&(dataset$DBMS==db), 'Kernel Exec.Time'])
    }
  }
  
  return(dataset)
}

#각 쿼리에 대해, DBMS별로 log transformation한 다음, 평균을 구하고 query별로 ploting할 것
# kerninv 는 minmax !!!!!!!!
AggregateByQuery <- function(logscale,feature){
  
  Query=c('Q1', 'Q2','Q3','Q4','Q5','Q6','Q7','Q8','Q9','Q10','Q11','Q12','Q13','Q14',
          'Q15','Q16','Q17','Q18','Q19','Q20','Q21','Q22')
  dbms=c('BlazingSQL', 'PG-Strom', 'OmniSci')
  
  df <- data.frame(Query.Name=Query)

  for(db in dbms){
   if(feature=='Num. of Kern.Inv'){
     df <-merge(x=df, y=(filter(logscale, DBMS==db) %>% 
       group_by(Query.Name) %>% summarise(db=mean(`Num. of Kern.Inv`))), 
       all.x=TRUE, by='Query.Name')
     
   }else if(feature=='Kernel Exec.Time'){
     df <- merge(x=df, y=(filter(logscale, DBMS==db) %>% 
       group_by(Query.Name) %>% summarise(db=mean(`Kernel Exec.Time`))), 
       all.x=TRUE,by='Query.Name')
   }
  }
  if(feature=='Num. of Kern.Inv')
    df <-merge(x=df, y=(logscale %>% group_by(Query.Name) %>% summarise(db=mean(`Num. of Kern.Inv`))), 
               all.x=TRUE,by='Query.Name')
  else
    df <-merge(x=df, y=(logscale %>% group_by(Query.Name) %>% summarise(db=mean(`Kernel Exec.Time`))),
               all.x=TRUE,by='Query.Name')
  
  colnames(df) <- c(feature, 'BlazingSQL', 'PG-Strom', 'OmniSci', 'Entire')
  
  df <- df[c(1,12,16:22,2:11,13:15),]
  return(df)
}

# Aggregate 그래프
Aggre_Graph <- function(agg, dbmsname){

  feature=colnames(agg[1])
  df <- agg[c(feature, dbmsname)]
  
  min_ = min(floor(df[2]), na.rm = TRUE)
  max_ = max(ceiling(df[2]), na.rm = TRUE)
  
  plot(df[,2], type='o', col=1, ylim=c(min_, max_), axes=FALSE, xlab='Query Name', ylab=feature,
       main = paste(dbmsname, feature, sep=" "))
  axis(1,at=1:length(df[,1]), lab=df[,1], lty=1, lwd=0.8)
  axis(2, ylim=c(min_, max_))
  
  abline(h=quantile(df[,2], 0.25), lty=2)
  abline(h=quantile(df[,2], 0.5), lty=2)
  abline(h=quantile(df[,2], 0.75), lty=2)
}

# Entire Aggregate 그래프
Agg_EntirePlot <- function(agg){
  
  names=c('Entire', 'BlazingSQL', 'PG-Strom', 'OmniSci')
  feature = colnames(agg[1])
  
  min_ = min(floor(agg[-1]), na.rm = TRUE)
  max_ = max(ceiling(agg[-1]), na.rm = TRUE)
  
  plot(agg[,"Entire"], type='o', col=1, ylim=c(min_, max_), axes=FALSE,xlab='Query Name', ylab=feature,
         main =paste('Total', feature, sep=" ") )
  lines(agg[,"BlazingSQL"], type='o', col=2)
  lines(agg[,"PG-Strom"], type='o', col=3)
  lines(agg[,"OmniSci"], type='o', col=4)
    
  axis(1,at=1:length(agg[,1]), lab=agg[,1], lty=1, lwd=0.8)
  axis(2, ylim=c(min_, max_))
  
  
  x_= ifelse(feature=='Num. of Kern.Inv', 18,16)
  y_= ifelse(feature=='Num. of Kern.Inv', 2,18)
  
  legend(x_, y_, names, cex=0.7, pch=1, col=1:length(names), lty = 1)
  
}

# Overlap 그래프
Agg_EntirePlot <- function(kerninv, kerntime, dbms){
  
  
  query <- kerninv[1]

  #feature = colnames(kerninv[1])
  
  min_ = min(floor(kerninv[-1]), na.rm = TRUE)
  max_ = max(ceiling(dernitme[-1]), na.rm = TRUE)
  
  plot(agg[,"Entire"], type='o', col=1, ylim=c(min_, max_), axes=FALSE,xlab='Query Name', ylab=feature,
       main =paste('Total', feature, sep=" ") )
  lines(agg[,"BlazingSQL"], type='o', col=2)
  lines(agg[,"PG-Strom"], type='o', col=3)
  lines(agg[,"OmniSci"], type='o', col=4)
  
  axis(1,at=1:length(agg[,1]), lab=agg[,1], lty=1, lwd=0.8)
  axis(2, ylim=c(min_, max_))
  
  
  x_= ifelse(feature=='Num. of Kern.Inv', 18,16)
  y_= ifelse(feature=='Num. of Kern.Inv', 2,18)
  
  legend(x_, y_, names, cex=0.7, pch=1, col=1:length(names), lty = 1)
  
}

# Kerninv, Kerntime 중첩 plotting
duplicate_Plot <- function(aggre_kerninv){
  df <- aggre_kerninv["Entire"]
  plot(df[,1], type='o', axes=FALSE, xlab = "Query", ylab='Kerninv') 
  time <- aggre_kerntime["Entire"]
  lines(time[,1], col="red")
  axis(1, at=1:length(aggre_kerninv[,1]), lab=aggre_kerninv[,1],
       lty=1, lwd=0.8)
  axis(2,)
  abline(h=quantile(df[,1], 0.25), lty=2)
  abline(h=quantile(df[,1], 0.5), lty=2)
  abline(h=quantile(df[,1], 0.75), lty=2)
  par(new=TRUE)
  plot(time[,1], type="o", axes=FALSE, xlab = "", ylab = "",
       col="red")
  axis(4, col="red")
  abline(h=quantile(time[,1], 0.25), lty=2, col="red")
  abline(h=quantile(time[,1], 0.5), lty=2,col="red")
  abline(h=quantile(time[,1], 0.75), lty=2, col="red")
  mtext("kerntime", 4, col = "red")
}

##### main #####


folder <- 'C:/Users/USER/Documents/BenchGAD'
setwd(folder)
dataset <- read.csv(file=paste0(folder, '/dataset.csv'), header = TRUE,stringsAsFactors = FALSE)

query <- dataset[c(2, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 21, 22)]
names(query) <- c('DBMS', 'Query.Name','Pres. of Agg','Pres. of Subq.', 'Num. of Joins', 
                  'Num. of Ref.Attr. on FT', 'Num. of Ref. Attr. by Que.', 'Num. of Ref. Tab',
                  'Num. of Ref.Dist.Tab', 'Avail. Case.when', 'Pres. Order.by','Num. of Kern.Inv', 'Kernel Exec.Time')

kerneldataset <- query_preprocessing(dataset)
logscale <- LogTransformByQuery(kerneldataset)

aggre_kerninv <- AggregateByQuery(logscale, 'Num. of Kern.Inv')
aggre_kerntime <- AggregateByQuery(logscale, 'Kernel Exec.Time')

dbmses <- c('BlazingSQL', 'PG-Strom', 'OmniSci', 'Entire')


# Plotting
Aggre_Graph(aggre_kerntime, "BlazingSQL") # min, max 다 표시해주기 
Aggre_Graph(aggre_kerntime, "PG-Strom")
Aggre_Graph(aggre_kerntime, "OmniSci")
Aggre_Graph(aggre_kerntime, "Entire")

Aggre_Graph(aggre_kerninv, "Entire")
Aggre_Graph(aggre_kerntime, "Entire")

# Kerninv, Kerntime 중첩 plotting
duplicate_Plot(aggre_kerninv)


###################################################

# 같은 경향성 띄는 쿼리 Q22, Q18, Q19 Q3, Q12, Q15, Q21
same_kerninv <- aggre_kerninv[c(3,12,15,18,19,21,22),]
same_kerntime <- aggre_kerntime[c(3,12,15,18,19,21,22),]

sdf <- same_kerninv["Entire"]
plot(sdf[,1], type='o', axes=FALSE, xlab = "Query", ylab='Kerninv') 
stime <- same_kerntime["Entire"]
lines(stime[,1], col="red")
axis(1, at=1:length(same_kerninv[,1]), lab=same_kerninv[,1],
     lty=1, lwd=0.8)
axis(2,)
abline(h=quantile(sdf[,1], 0.25), lty=2)
abline(h=quantile(sdf[,1], 0.5), lty=2)
abline(h=quantile(sdf[,1], 0.75), lty=2)
par(new=TRUE)
plot(stime[,1], type="o", axes=FALSE, xlab = "", ylab = "",
     col="red")
axis(4, col="red")
abline(h=quantile(stime[,1], 0.25), lty=2, col="red")
abline(h=quantile(stime[,1], 0.5), lty=2,col="red")
abline(h=quantile(stime[,1], 0.75), lty=2, col="red")
mtext("kerntime", 4, col = "red")

# Kerninv, Kerntime 기준 25% 이하(Q15,Q22) 75% 이하(Q19,Q21) 쿼리 특성 살펴보기 
q1 <- filter(query, Query.Name=="Q15" | Query.Name=='Q22')
q3 <- filter(query, Query.Name=="Q19" | Query.Name=="Q21")
colnames(q1)
q1$`Num. of Ref.Dist.Tab`
q1 %>% summarise(mean_RefQue=mean(`Num. of Ref. Attr. by Que.`), median_RefQue=median(`Num. of Ref. Attr. by Que.`),
                 mean_RefFT=mean(`Num. of Ref.Attr. on FT`), median_RefFT=median(`Num. of Ref.Attr. on FT`))
q3 %>% summarise(mean_RefQue=mean(`Num. of Ref. Attr. by Que.`), median_RefQue=median(`Num. of Ref. Attr. by Que.`),
                 mean_RefFT=mean(`Num. of Ref.Attr. on FT`), median_RefFT=median(`Num. of Ref.Attr. on FT`))
summarise_each(q1, funs(mean, median, min, max), `Num. of Joins`,
               `Num. of Ref.Attr. on FT`,`Num. of Ref. Attr. by Que.`,`Num. of Ref. Tab`,`Num. of Ref.Dist.Tab`)
summarise_each(q3, funs(mean, median, min, max), `Num. of Joins`,
               `Num. of Ref.Attr. on FT`,`Num. of Ref. Attr. by Que.`,`Num. of Ref. Tab`,`Num. of Ref.Dist.Tab`)

##############################
feature=colnames(agg[1])
df <- agg[c(feature, dbmsname)]

min_ = min(floor(df[2]), na.rm = TRUE)
max_ = max(ceiling(df[2]), na.rm = TRUE)

plot(df[,2], type='o', col=1, ylim=c(min_, max_), axes=FALSE, xlab='Query Name', ylab=feature,
     main = paste(dbmsname, feature, sep=" "))
axis(1,at=1:length(df[,1]), lab=df[,1], lty=1, lwd=0.8)
axis(2, ylim=c(min_, max_))

abline(h=quantile(df[,2], 0.25), lty=2)
abline(h=quantile(df[,2], 0.5), lty=2)
abline(h=quantile(df[,2], 0.75), lty=2)

afterscale <- MM_Groupby(dataset, c('Num. of Kern.Inv', 'Kernel Exec.Time'), 1)

blazingsql <- filter(afterscale, DBMS=='BlazingSQL')
pgstrom <- filter(afterscale, DBMS=='PG-Strom')
omnisci <- filter(afterscale, DBMS=='OmniSci')

# kernel inv 1 인것만 kernel time NA

blaagg <- blazingsql %>% 
  group_by(Query.Name) %>%
  summarise(mean_kernelInv=mean(`Num. of Kern.Inv`),
            mean_kernelTime=mean(`Kernel Exec.Time`))

pgstromagg <- pgstrom %>% 
  group_by(Query.Name) %>%
  summarise(mean_kernelInv=mean(`Num. of Kern.Inv`),
            mean_kernelTime=mean(`Kernel Exec.Time`))

omnisciagg  <- omnisci %>% 
  group_by(Query.Name) %>%
  summarise(mean_kernelInv=mean(`Num. of Kern.Inv`),
            mean_kernelTime=mean(`Kernel Exec.Time`))

entireagg  <- afterscale %>% 
  group_by(Query.Name) %>%
  summarise(mean_kernelInv=mean(`Num. of Kern.Inv`),
            mean_kernelTime=mean(`Kernel Exec.Time`))

Graph(blaagg, 'mean_kernelInv','BlazingSQL')
Graph(pgstromagg,'mean_kernelInv','PG-Strom')
Graph(omnisciagg,'mean_kernelInv','OmniSci')
Graph(entireagg,'mean_kernelInv','Entire')
Graph(entireagg,'mean_kernelTime','Entire')

EntirePlot(blaagg, pgstromagg, omnisciagg, entireagg,'mean_kernelInv')
EntirePlot(blaagg, pgstromagg, omnisciagg, entireagg,'mean_kernelTime')





