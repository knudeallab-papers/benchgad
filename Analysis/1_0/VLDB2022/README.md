# main.R

Description of main.R

# NormalizationandCorrelation.R

Description of NormalizationandCorrelation.R

# QueryKernel.R

Description of QueryKernel.R

# ReArrange.R

Description of ReArrange.R


# raw_dataset.csv


```
Row_No,DBMS,IM,CF,MG,RAM_Size,Gen,GM,IC,DB_Size,QNo,AGG,SQ,NumJoins,NumFTAtts,NumAllAtts,NumAllTbl,NumDsTbl,CW,OB,HDT,DHT,PF,NumIK,KT,ET
1,BlazingSQL,T,T,F,48,2080ti,11,-,1,Q1,T,F,0,7,7,1,1,F,T,341.471,81.568,0,140,18516.95,37272
...
```

- **Row_No**: The number of each row.
- **DBMS**: The name of each DBMS.
- **IM**: Indicates whether each DBMS is **I**n-**M**emory or not.
- **CF**: row-oriented or column-oriented
- **MG**: Multi-GPU
- **RAM_Size**: ram size
- **Gen**: gpu generation
- **GM**: gpu memory
- **IC**: interconnection
- **DB_Size**: dataset size
- **QNo**: number of query
- **AGG**: aggregation
- **SQ**: subquery
- **NumJoins**: number of joins
- **NumFTAtts**: number of attributes to be referenced (on the fact table)
- **NumAllAtts**: number of (projection+selection) attributes to be referenced by query
- **NumAllTbl**: number of all tables to be referenced
- **NumDsTbl**: number of distinct tables to be referenced
- **CW**: case-when
- **OB**: order by
- **HDT**: htod time
- **DHT**: dtoh time
- **PF**: page fault
- **NumIK**: number of kernels invoked
- **KT**: kernel time
- **ET**: elapsed time
