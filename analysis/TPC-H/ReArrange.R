RowName="Row_No"
queryNumber="QNo"

full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'CC', 'QNo','AGG',
                  'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                  'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET','DT')

preprocessing <- function(dataset){
  
  dataset <- na.omit(dataset)
  
  dataset$Gen <- sapply(dataset$Gen, function(x){ifelse(x=='3090', 3, ifelse(x=='2080ti', 2, 1))})
  dataset$MG <- sapply(dataset$MG, function(x){ifelse(x==FALSE, 1, ifelse(x==TRUE, 2, 0))})
  
 dataset[, c('IM','CF','AGG','SQ','CW','OB')] <- lapply(dataset[, c('IM','CF','AGG','SQ','CW','OB')],function(x){ifelse(x==TRUE, 1, 0)})
  dataset[, c('ET','NumIK','CC','PF','HDT','DHT','DT')] <- lapply(dataset[,c('ET','NumIK','CC','PF','HDT','DHT','DT')], as.numeric)
  
  dataset <- dataset[!(dataset$QNo =="Q11")&!(dataset$QNo =="Q20")&!(dataset$QNo =="Q21")&!(dataset$QNo =="Q22"),]

  return(dataset)
}

MinMaxNormalize <- function(x)
  return((x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x,na.rm = T)))

Normalize_GroupbyDBMS <- function(dataset, DBMS_NAME, nontime_feature, time_feature){
  Query <- unique(dataset[,queryNumber])
  
  if(DBMS_NAME =='BlazingSQL' || DBMS_NAME=='PG-Strom' || DBMS_NAME=='OmniSci') 
    data <- filter(dataset, DBMS==DBMS_NAME)
  else{
    print("DBMS parameter must be 'BlazingSQL' or 'PG-Strom' or 'OmniSci'")
    return(-1)
  }
  
  for(query in Query){
    for(feature in time_feature)
      data[(data[,queryNumber]==query), feature]=log1p(data[(data[,queryNumber]==query), feature])
  }
  
  for(feature in nontime_feature) 
    data[feature] <- MinMaxNormalize(data[feature])

  return(data)
}