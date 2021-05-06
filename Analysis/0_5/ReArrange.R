#install.packages("dplyr")
#library(dplyr)
#install.packages("pastecs")
#library(pastecs)
#install.packages("ggplot2")
#library(ggplot2)

RowName="Row_No"
queryNumber="QNo"

full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'QNo','AGG',
                      'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                      'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET')


# ?????ͼ? ??ó??
preprocessing <- function(dataset){
  
  dataset <- na.omit(dataset)
  
  dataset$Gen <- sapply(dataset$Gen, function(x){ifelse(x=='2080ti', 1,0)})
  
  dataset[, c('IM','CF','MG','AGG','SQ','CW','OB')] <- lapply(dataset[, c('IM','CF','MG','AGG','SQ','CW','OB')],function(x){ifelse(x==TRUE, 1, 0)})
  dataset[, c('ET','NumIK','PF','DHT')] <- lapply(dataset[,c('ET','NumIK','PF','DHT')], as.numeric)
 
  dataset <- dataset[!(dataset$QNo =="Q11")&!(dataset$QNo =="Q20")&!(dataset$QNo =="Q21")&!(dataset$QNo =="Q22"),]
  #dataset <- dataset[c(1:19, 21:23)]

  #dataset <- dataset[c(1:19, 21:23)]
  #names(dataset) <- full_feature
  return(dataset)
}

# Minmax ??ȭ 
MinMaxNormalize <- function(x)
  return((x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x,na.rm = T)))

# ??ȭ ?Լ? 
Normalize_GroupbyDBMS <- function(dataset, DBMS_NAME, nontime_feature, time_feature){
  Query <- unique(dataset[,queryNumber])
  
  if(DBMS_NAME =='BlazingSQL' || DBMS_NAME=='PG-Strom' || DBMS_NAME=='OmniSci') 
    data <- filter(dataset, DBMS==DBMS_NAME)
  else{
    print("DBMS parameter must be 'BlazingSQL' or 'PG-Strom' or 'OmniSci'")
    return(-1)
  }
  
  # Time feature?? Query?? log transformation 
  for(query in Query){
    for(feature in time_feature)
      data[(data[,queryNumber]==query), feature]=log1p(data[(data[,queryNumber]==query), feature])
  }
  
  # nontime feature?? minmax normalization
  for(feature in nontime_feature)
    data[feature] <- MinMaxNormalize(data[feature])
  
  return(data)
}


# trimpoint% ?̿? ?????Ǵ? outlier count 0~4??
OutlierCount <- function(df, features, trimpoints){
  
  percent_ <- c("Raw")
  
  df[RowName] <- seq(1:nrow(df[RowName]))
  db <- df %>% select(RowName,features)
  
  mt <- matrix(1:(length(trimpoints)+1),nrow=length(trimpoints)+1, ncol=5)
  
  for(i in 0:5)
    mt[1,i]= nrow(db[RowName])
  
  for(idx in 1:length(trimpoints)){
    
    percent_ <- c(percent_, paste(round((trimpoints[idx]*100), digit=1), "%", sep=""))
    
    count_vector <-  vector("numeric", nrow(db[RowName]))
    
    for(col in features){
      new <- db[c(order(-db[col])), RowName]
      index <-ceiling(nrow(db[col])*((1-trimpoints[idx])*100))
      
      for(rowno in new[1:index])
        count_vector[rowno]=count_vector[rowno]+1
    }
    
    for(cnt in 0:4)
      mt[idx+1, cnt+1]=length(which(cnt==count_vector))
    mt[idx+1,5]=length(which(4<=count_vector))
  }
  
  mt <- data.frame(mt)
  
  rownames(mt) <- percent_
  colnames(mt) <- c('0','1','2','3','4+')
  
  return(mt)
}

# Ư trimpoint???? 4?? ?̻? columns???? outlier?Ǵ? sample ????
Trim_Outlier <- function(df, features, trimpoint){
  
  df[RowName] <- seq(1:nrow(df[RowName]))
  db <- df
  
  count_vector <-  vector("numeric", nrow(db[RowName]))
  
  for(col in features){
    new <- db[c(order(-db[col])), RowName]
    index <-ceiling(nrow(db[col])*(100-trimpoint))
    
    for(rowno in new[1:index])
      count_vector[rowno]=count_vector[rowno]+1
  }
  
  slice_index <- which(4<=count_vector)
  
  db <- db[-slice_index, ]
  
  return(db)
}

# trimpoint% ?̿? ?????Ǵ? outlier count
OutlierCount_prev <- function(df, dbms, features, trimpoints){
  
  
  percent_ <- c("Raw")
  #percent_ <- c("Raw", "sliceNA")
  
  if(dbms=='entire' || dbms=='blaomni')
    db <- df %>% select(RowName,features)
  else
    db <- filter(df, DBMS==dbms) %>% select(RowName,features)
  
  mt <- matrix(1:(length(trimpoints)+2),nrow=length(trimpoints)+2)
  mt[1,1]= nrow(db[RowName])
  mt[2,1]= sum(complete.cases(db))
  
  db <- na.omit(db)
  for(idx in 1:length(trimpoints)){
    set <- c(-1)
    percent_ <- c(percent_, paste(round((trimpoints[idx]*100), digit=1), "%", sep=""))
    for(col in features){
      new <- db[c(order(-db[col])),]
      new <- new[seq(1:(nrow(db[col])*(1-trimpoints[idx]))),]
      set <- union(set,new[,1])
    }
    set <- set[-1]
    mt[idx+2,1]=nrow(db)-length(set)
  }
  mt <- data.frame(mt)
  if(dbms=='PG-Strom')
    names(mt) <- c('PGStrom')
  else if(dbms=='entire')
    names(mt) <- c('Entire DBMS without PG-Strom DB>8')
  else if(dbms=='blaomni')
    names(mt) <- c('BlazingSQL+OmniSci')
  else
    names(mt) <- c(dbms)
  
  rownames(mt) <- percent_
  return(mt)
}

# Ư % ?̻? outlier ????
Trim_Outlier_prev <- function(df, features, point){
  db <- na.omit(df)
  set <- c(-1)
  for(col in features){
    new <- db[c(order(-db[col])),]
    new <- new[seq(1:(nrow(db[col])*(1-point))),]
    set <- union(set,new[,1]) 
  }
  set <- set[-1]
  db <- db[-set,]
  return(db)
}

# Entire Df?? ?? ?ε??? ??
Make_index <- function(entire, trimpoints){
  percent_ <- c("Raw", "sliceNA")
  for(idx in 1:length(trimpoints)){
    percent_ <- c(percent_, paste(round(trimpoints[idx]*100, digits = 1), "%", sep=""))
  }
  rownames(entire) <- percent_
  return(entire)
}

# ?? DBMS Sliced Outlier ?? plt
EntirePlot <- function(entire_agg){
  
  index <- rownames(entire_agg)[-1]
  nrows <- nrow(entire_agg)
  ncols <- ncol(entire_agg)
  
  min_ <- min(entire_agg)-min(entire_agg)%%100
  if(max(entire_agg)%%100<50)
    max_=max(entire_agg)+50
  else 
    max_ = (max(entire_agg)%/%100)*100+100
  
  plot(entire_agg[2:nrows,1], type='o', col=1, ylim=c(min_, max_), axes=FALSE, xlab='Point(%)', ylab ='Sample', main = 'Outlier Slicing by DBMS')
  
  text_ <-c("100%")
  na=entire_agg[2,1]
  for(num in entire_agg[3:nrows,1])
    text_ <- c(text_, paste(round((num/na)*100, digits = 0), "%", sep=""))
  text(entire_agg[2:nrows,1], text_, pos=1)
  
  for(idx in 2:ncols){
    lines(entire_agg[2:nrows,idx], type='o', col=idx)
    text_ <-c("100%")
    na=entire_agg[2,idx]
    for(num in entire_agg[3:nrows,idx])
      text_ <- c(text_, paste(round((num/na)*100, digits = 0), "%", sep=""))
    text(entire_agg[2:nrows,idx], text_, pos=3)
  }
  
  axis(1,at=1:length(index), lab=index)
  axis(2, ylim=c(min_, max_))
  
  colname <- colnames(entire_agg)
  
  legend(nrows-4, max_+65, colname, cex=0.7, pch=1, col=1:ncols, lty = 1)
}

# ???? DBMS Sliced Outlier ?? plt 
Indivisual_Plot <- function(dbms_agg){
  index <- rownames(dbms_agg)[-1]
  nrows <- nrow(dbms_agg)
  colname <- colnames(dbms_agg)
  
  min_ <- min(dbms_agg)-min(dbms_agg)%%100
  if(max(dbms_agg[2,])%%100<50)
    max_=(max(dbms_agg[2,])%/%100)*100+50
  else 
    max_ = (max(dbms_agg[2,])%/%100)*100+100
  
  plot(dbms_agg[2:nrows,1], type='o', col=1, ylim=c(min_, max_), axes=FALSE, xlab='Point(%)', ylab ='Sample',
       main = paste('Outlier Slicing by', colname, sep=" "))
  
  text_ <-c("100%")
  na=dbms_agg[2,1]
  for(num in dbms_agg[3:nrows,1])
    text_ <- c(text_, paste(round((num/na)*100, digits = 0), "%", sep=""))
  text(dbms_agg[2:nrows,1], text_, pos=3 )
  ReArrange.R
  axis(1,at=1:length(index), lab=index, lty=1, lwd=0.8)
  axis(2, ylim=c(min_, max_))

  legend(3, max_, colname, cex=0.8, pch=1, col=1, lty = 1)
}

# Trimpoints ???? ??????
Make_Trimpoints <- function(start, end, interval){
  cnt <- (start-end)/interval
  points <- c()
  for(i in 1:cnt){
    points <- c(points, (start-interval)*0.01)
    start=start-interval
  }
  return(points)
}

# ????????
Correlation <- function(df){
  db<- subset(df, select=-c(`Row No.`, DBMS, QNo))
  
  col_length <- length(colnames(db))
  corr <- cor(db[,c(1:col_length)], db[, c((col_length-4):col_length)], use="pairwise.complete.obs")
  
  return(corr)
}



