
ShowStat <- function(dataset)
  
  min(dataset$DT, na.rm=T)
  max(dataset$DT, na.rm=T)
  mean(dataset$DT, na.rm=T)
  sd(dataset$DT, na.rm=T)
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
  min(dataset$PF, na.rm=T)
  max(dataset$PF, na.rm=T)
  mean(dataset$PF, na.rm=T)
  
  
  ## number of invoked kernels
  dataset$NumIK[dataset$NumIK==""] <- NA
  dataset$NumIK[dataset$NumIK=="err"] <- NA
  dataset$NumIK <- as.integer(dataset$NumIK)
  min(dataset$NumIK, na.rm=T)
  max(dataset$NumIK, na.rm=T)
  mean(dataset$NumIK, na.rm=T)
  
  ## kernel time 
  dataset$KT[dataset$KT==""] <- NA
  dataset$KT[dataset$KT=="err"] <- NA
  #KT <- na.omit(dataset$KT) 
  dataset$KT <- as.double(dataset$KT)
  min(dataset$KT, na.rm=T)
  max(dataset$KT, na.rm=T)
  mean(dataset$KT, na.rm=T)
  sd(dataset$KT, na.rm=T)
  
  ## query time 
  dataset$ET[dataset$ET==""] <- NA
  dataset$ET[dataset$ET=="err"] <- NA
  dataset$ET <- as.double(dataset$ET)
  min(dataset$ET, na.rm=T)
  max(dataset$ET, na.rm=T)
  mean(dataset$ET, na.rm=T)
  sd(dataset$ET, na.rm=T)