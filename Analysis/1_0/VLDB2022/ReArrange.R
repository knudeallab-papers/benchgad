RowName="Row_No"
queryNumber="QNo"

full_feature <- c(RowName, 'DBMS', 'IM', 'CF', 'MG', 'RAM_Size', 'Gen', 'GM', 'DB_Size', 'QNo','AGG',
                      'SQ', 'NumJoins', 'NumFTAtts', 'NumAllAtts', 'NumAllTbl',
                      'NumDsTbl', 'CW', 'OB', 'HDT','DHT','PF','NumIK', 'KT','ET')

preprocessing <- function(dataset){
  
  dataset <- na.omit(dataset)
  
  dataset$Gen <- sapply(dataset$Gen, function(x){ifelse(x=='3090', 3, ifelse(x=='2080ti', 2, 1))})
  
  dataset[, c('IM','CF','MG','AGG','SQ','CW','OB')] <- lapply(dataset[, c('IM','CF','MG','AGG','SQ','CW','OB')],function(x){ifelse(x==TRUE, 1, 0)})
  dataset[, c('ET','NumIK','PF','DHT')] <- lapply(dataset[,c('ET','NumIK','PF','DHT')], as.numeric)
 
  dataset <- dataset[!(dataset$QNo =="Q11")&!(dataset$QNo =="Q20")&!(dataset$QNo =="Q21")&!(dataset$QNo =="Q22"),]
  #dataset <- dataset[c(1:19, 21:23)]

  #dataset <- dataset[c(1:19, 21:23)]
  #names(dataset) <- full_feature
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




