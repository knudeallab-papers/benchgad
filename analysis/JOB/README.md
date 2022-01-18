# integrated_raw_dataset.csv

```
Row_No,DBMS,IM,CF,MG,RAM_Size,Gen,GM,DB_Size,CC,QNo,AGG,SQ,NumJoins,NumFTAtts,NumAllAtts,NumAllTbl,NumDsTbl,CW,OB,HDT,DHT,PF,NumIK,KT,ET,DT
1,BlazingSQL,T,T,F,48,2080ti,11,1,4352,Q1,T,F,0,7,7,1,1,F,T,341.471,81.568,0,140,18516.95,37272,341.471
...
```

- **Row_No**: The number of each row.
- **DBMS**: The name of DBMS.
- **IM**: Indicates whether In-Memory operation was used or not.
- **CF**: Indicates whether row-oriented operation was used or column-oriented operation was used.
- **MG**: Indicates whether Multi-GPU was used or not. 

    >Related to **_Hardware Complexity - Number of GPU cards_** in Figure 1.

- **RAM_Size**: The size of RAM. 

    >Related to **_Hardware Complexity - Amount of host memory_** in Figure 1.

- **Gen**: The generation of GPU. 

    >Related to **_Hardware Complexity - Number of GPU cores_** in Figure 1.

- **GM**: The size of VRAM. 

    >Related to **_Hardware Complexity - Amount of device memory_** in Figure 1.

- **DB_Size**: The size of [TPC-H](http://www.tpc.org/tpch/) data. 

    >Related to **_Data Complexity - Scale of data volume_** in Figure 1.

- **CC**: The number of GPU engine CUDA Cores. 

    >Related to **_Hardware Complexity - Number of CUDA Cores_** in Figure 1.
	
- **QNo**: The sequence number of each [TPC-H](http://www.tpc.org/tpch/) query.

- **AGG**: Indicates whether each query has _aggregation_ operation or not. 

    >Related to **_Query Complexity - Presence of aggregate_** in Figure 1.

- **SQ**: Indicates whether each query has _subquery_ operation or not. 

    >Related to **_Query Complexity - Presence of subquery_** in Figure 1.

- **NumJoins**: The number of joins.

    >Realted to **_Query Complexity - Number of joins_** in Figure 1.

- **NumFTAtts**: The number of attributes to be referenced on the fact table.

- **NumAllAtts**: The number of attributes to be referenced by query.

    >Related to **_Query Complexity - Number of used attributes_** in Figure 1.

- **NumAllTbl**: The number of all tables to be referenced.

- **NumDsTbl**: The number of distinct tables to be referenced.

- **CW**: Indicates whether each query has _case-when_ operation or not. 

- **OB**: Indicates whether each query has _order by_ operation or not. 

- **HDT**: Data migration(_HtoD_) time.

- **DHT**: Data migration(_DtoH_) time.

- **PF**: The number of _page fault_.

    >Related to **_Kernel Complexity - Number of page faults_** in Figure 1.

- **NumIK**: The number of kernels invoked.

    >Related to **_Kernel Complexity - Number of invoked kernels_** in Figure 1.

- **KT**: The kernel execution time of each query.

    >Related to **_Kernel Complexity - Kernel execution time_** in Figure 1.
    
- **ET**: The elapsed time of each query.

    >Related to **_Query time_** in Figure 1.

- **DT**: Data transfer time.

    >Related to **_Kernel Complexity - Data transfer time_** in Figure 1.
	
<br>

# Analysis.R

Description of Analysis.R

## Correlation analysis

example of correlation analysis between KT and ET using `cor.test()` function

```R
dataset <- read.csv(file=paste0(folder, '/raw_dataset.csv'), header = TRUE,stringsAsFactors = FALSE)
preprocessed_dataset <- preprocessing(dataset)
blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)
pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)
omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)
entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)
test <- as.data.frame(cbind(X=entire_dataset$KT, Y=entire_dataset$ET))
res <- cor.test(test$X,test$Y, 
                method = "pearson")
res
```

<br>

## Regression analysis
example of regression analysis between ET and DT + KT using `lm()` function.

```R
dataset <- read.csv(file=paste0(folder, '/raw_dataset.csv'), header = TRUE,stringsAsFactors = FALSE)
preprocessed_dataset <- preprocessing(dataset)
blazingsql <- Normalize_GroupbyDBMS(preprocessed_dataset,"BlazingSQL",nontime_feature,time_feature)
pgstrom <- Normalize_GroupbyDBMS(preprocessed_dataset,"PG-Strom",nontime_feature,time_feature)
omnisci <- Normalize_GroupbyDBMS(preprocessed_dataset,"OmniSci",nontime_feature,time_feature)
entire_dataset <- bind_rows(blazingsql, pgstrom) %>% bind_rows(omnisci)
fit_et = lm(ET ~ DT + KT, data = entire_dataset) 
summary(fit_et) # 76.67%
```

<br>

# ReArrange.R

`ReArrange.R` defines the functions used in `Analysis.R`
