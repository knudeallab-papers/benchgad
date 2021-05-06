library(dplyr)
library(pastecs)

#Preprocessing
#Input : 'Integrated_concat.csv'
#Output : 1) Correlation (feature name) <- Entire, by DBMS
#         2) csv file <- Entire, by DBMS

df <- read.csv(file='Integrated_concat.csv', header = TRUE, stringsAsFactors = FALSE)
df[, c(21:30)] <- lapply(df[, c(21:30)], as.numeric)
df <- mutate(df, DataTransferTime=(HtoD.time....+DtoH.time....)/2) 
df$GPU.Utilization...Kernel.Time.... <- (df$GPU.Utilization...Kernel.Time....)*0.01
df <- df[c(1:22,32,23:29)]

oldnames= c('X..of.joins','X..of.attributes..to.be.referenced...on.the.fact.table.','X..of..projection.selection..attributes.to.be.referenced.by.query',
            'X..of.all.tables..to.be.referenced','X..of.distinct.tables..to.be.referenced', 'X..of.kernels..invoked','GPU.utilization..Kernel.Time....','GPU.Utilization...Kernel.Time....','Elapsed.Time....')
newnames=c('Num of joins','Num of Ref Attri on F.T','Num of Ref Attri by Que','Num of All Ref Tables','Num of Distinc Ref Tables','Num of Kernel Inv','GPU util.kernel time','GPU util.kernel time(%)','Elapsed.Time')
df <- df %>% rename_at(vars(oldnames), ~newnames)

#Entire MinMax Normalization
MinMaxNormalize <- function(x)
  return((x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x,na.rm = T)))

entire <- df
entire$Evolution <- sapply(entire$Evolution, function(x){ifelse(x=='2080ti', 2,1)})

for(col in colnames(entire)){
  if(is.logical(entire[, col])){
    entire[,col]<-sapply(entire[,col], function(x){ifelse(x==TRUE, 1,0)})
  }else if(is.numeric(entire[, col])){
    cols=c("Row.No.","InO.memory","column..orientedness","Multi.GPU", "aggregation")
     if(!(col%in% cols)){
      entire[col] <- MinMaxNormalize(entire[col])}
    }
}

#Entire Correlation
entire <- subset(entire, select=-c(Row.No., DBMS, Interconnect, Query.Name, HtoD.time...., DtoH.time....,Elapsed.Time..on.NVProf..ms., Profiling..Overhead..ms., cudaLaunchKernel..start.time..ms.)) 
#1) correlation (dataframe)
correlation <- cor(entire[,c(1:21)], entire[, c(16:21)], use="pairwise.complete.obs")
#2) to csv
write.csv(correlation, file="EntireCorrelation.csv", row.names = T)

#DBMS MinMax Normalization
dbms <- df
dbms$Evolution <- sapply(dbms$Evolution, function(x){ifelse(x=='2080ti', 2,1)})

for(col in colnames(dbms)){
  if(is.logical(dbms[, col]))
    dbms[,col]<-sapply(dbms[,col], function(x){ifelse(x==TRUE, 1,0)})
}

BlazingSQL_ <- dbms %>% filter(DBMS =="BlazingSQL")
PGStrom_ <- dbms %>% filter(DBMS == "PG-Strom")
OmniSci_ <- dbms %>% filter(DBMS == "OmniSci")

cols=c("Row.No.","In.memory","column..orientedness","Multi.GPU", "aggregation")
for(col in colnames(dbms)){
  if(is.numeric (dbms[,col])){
    if(!(col%in% cols)){
      BlazingSQL_[col] <-MinMaxNormalize(BlazingSQL_[col])
      PGStrom_[col] <-MinMaxNormalize(PGStrom_[col])
      OmniSci_[col] <-MinMaxNormalize(OmniSci_[col])
      }
    }
}

#DBMS Correlation

#write.csv(BlazingSQL_, file = "BlazingSQLNormalize.csv")   
BlazingSQL_ <- subset(BlazingSQL_, select=-c(Row.No., DBMS, Interconnect, Query.Name, HtoD.time...., DtoH.time....,Elapsed.Time..on.NVProf..ms., Profiling..Overhead..ms., cudaLaunchKernel..start.time..ms. )) 
#1) correlation (dataframe)
correlation <- cor(BlazingSQL_[,c(1:21)], BlazingSQL_[, c(16:21)], use="pairwise.complete.obs")
#2) to csv
write.csv(correlation, file="BlazingSQLCorrelation.csv", row.names = T)

#write.csv(PGStrom_, file = "PGStrom_Normalize.csv")   
PGStrom_ <- subset(PGStrom_, select=-c(Row.No., DBMS, Interconnect, Query.Name, HtoD.time...., DtoH.time....,Elapsed.Time..on.NVProf..ms., Profiling..Overhead..ms., cudaLaunchKernel..start.time..ms. )) 
#1) correlation (dataframe)
correlation <- cor(PGStrom_[,c(1:21)], PGStrom_[, c(16:21)], use="pairwise.complete.obs")
#2) to csv
write.csv(correlation, file="PGStromCorrelation.csv", row.names = T)

#write.csv(OmniSci_, file = "OmniSci_Normalize.csv")   
OmniSci_ <- subset(OmniSci_, select=-c(Row.No., DBMS, Interconnect, Query.Name, HtoD.time...., DtoH.time....,Elapsed.Time..on.NVProf..ms., Profiling..Overhead..ms., cudaLaunchKernel..start.time..ms. )) 
#1) correlation (dataframe)
correlation <- cor(OmniSci_[,c(1:21)], OmniSci_[, c(16:21)], use="pairwise.complete.obs")
#2) to csv
write.csv(correlation, file="OmniSciCorrelation.csv", row.names = T)

