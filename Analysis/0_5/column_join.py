'''
require: python3
    
read_excel, if executed
pip3 install xlrd, otherwise
'''
import pandas as pd

query_sheet = 'query_sheet'
exp_sheet = 'experiment_results'
inputFileName = 'BenchGAD_Dataset.xlsx' 
outputFileName = 'raw_dataset.csv'
tempsheet=pd.read_excel(inputFileName, engine="openpyxl", sheet_name=query_sheet, header=3)
datasheet=pd.read_excel(inputFileName, engine="openpyxl", sheet_name=exp_sheet, header=1)

prev=pd.merge(datasheet.iloc[:,:11], tempsheet, on='QNo', how='left')
dataresult=pd.concat([prev, datasheet.iloc[:, 11:]], axis=1)

dataresult.to_csv(outputFileName, index=False)
