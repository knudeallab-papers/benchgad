
ShowStat <- function(dataset)
  
  min(dataset$DT, na.rm=T)
  max(dataset$DT, na.rm=T)
  mean(dataset$DT, na.rm=T)
  sd(dataset$DT, na.rm=T)

  #dt_1 <- data.frame(pg_dt) 
  #names(dt_1)[1] <- "DT"
  #dt_2 <- data.frame(om_dt)
  #names(dt_2)[1] <- "DT"
  #dt_3 <- data.frame(bl_dt)
  #names(dt_3)[1] <- "DT"
  #dt <- rbind(dt_1, dt_2) %>% rbind(dt_3)
  #dt <- na.omit(dt)
  #min(dt$DT)
  #max(dt$DT)
  #mean(dt$DT)
  #min(data[,2], na.rm=T)
  min(dataset$NumJoins, na.rm=T)
  max(dataset$NumJoins, na.rm=T)
  mean(dataset$NumJoins, na.rm=T)
  min(dataset$NumAllAtts, na.rm=T)
  max(dataset$NumAllAtts, na.rm=T)
  mean(dataset$NumAllAtts, na.rm=T)
  
  min(dataset$DB_Size, na.rm=T)
  max(dataset$DB_Size, na.rm=T)
  mean(dataset$DB_Size, na.rm=T)
  
  
  ## number of page faults 
  dataset$PF <- as.character(dataset$PF)
  dataset$PF[dataset$PF==""] <- NA
  dataset$PF[dataset$PF=="err"] <- NA
  dataset$PF <- as.integer(dataset$PF)
  #PF <- na.omit(dataset$PF)
  #dataset$PF <- sapply(dataset$PF, function(x){ifelse(x=='', 0, x)})
  #dataset$PF <- as.integer(dataset$PF)
  min(dataset$PF, na.rm=T)
  max(dataset$PF, na.rm=T)
  mean(dataset$PF, na.rm=T)
  
  
  ## number of invoked kernels
  dataset$NumIK[dataset$NumIK==""] <- NA
  dataset$NumIK[dataset$NumIK=="err"] <- NA
  dataset$NumIK <- as.integer(dataset$NumIK)
  #dataset$PF <- sapply(dataset$PF, function(x){ifelse(x=='', 0, x)})
  #dataset$PF <- as.integer(dataset$PF)
  min(dataset$NumIK, na.rm=T)
  max(dataset$NumIK, na.rm=T)
  mean(dataset$NumIK, na.rm=T)
  
  ## kernel time 
  dataset$KT[dataset$KT==""] <- NA
  dataset$KT[dataset$KT=="err"] <- NA
  #KT <- na.omit(dataset$KT) 
  dataset$KT <- as.double(dataset$KT)
  #dataset$PF <- sapply(dataset$PF, function(x){ifelse(x=='', 0, x)})
  #dataset$PF <- as.integer(dataset$PF)
  min(dataset$KT, na.rm=T)
  max(dataset$KT, na.rm=T)
  mean(dataset$KT, na.rm=T)
  sd(dataset$KT, na.rm=T)
  
  ## query time 
  dataset$ET[dataset$ET==""] <- NA
  dataset$ET[dataset$ET=="err"] <- NA
  dataset$ET <- as.double(dataset$ET)
  #dataset$PF <- sapply(dataset$PF, function(x){ifelse(x=='', 0, x)})
  #dataset$PF <- as.integer(dataset$PF)
  min(dataset$ET, na.rm=T)
  max(dataset$ET, na.rm=T)
  mean(dataset$ET, na.rm=T)
  sd(dataset$ET, na.rm=T)
  #dataset$PF <- as.character(dataset$PF)
  #dataset$ET[dataset$ET==""] <- NA
  #dataset$ET[dataset$ET=="err"] <- NA
  #dataset$ET <- as.integer(dataset$ET)
  #ET <- na.omit(dataset$ET)
  #dataset$PF <- sapply(dataset$PF, function(x){ifelse(x=='', 0, x)})
  #dataset$PF <- as.integer(dataset$PF)
  #min(ET)
  #max(ET)
  #mean(ET)
  #options(scipen = n) 