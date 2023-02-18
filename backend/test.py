import numpy as np
import pandas as pd
import pickle
# Load data
data=pd.read_csv('/home/jaden/Downloads/Finance_data.csv')

data.head()

# Import LabelEncoder
from sklearn import preprocessing

# Creating labelEncoder
le = preprocessing.LabelEncoder()

# Converting string labels into numbers.
# data['salary']=le.fit_transform(data['salary'])
# data['Departments ']=le.fit_transform(data['Departments '])
data['gender']=le.fit_transform(data['gender'])
data['Investment_Avenues']=le.fit_transform(data['Investment_Avenues'])
data['Stock_Marktet']=le.fit_transform(data['Stock_Marktet'])
data['Factor']=le.fit_transform(data['Factor'])
data['Objective']=le.fit_transform(data['Objective'])
data['Purpose']=le.fit_transform(data['Purpose'])
data['Duration']=le.fit_transform(data['Duration'])
data['Invest_Monitor']=le.fit_transform(data['Invest_Monitor'])
data['Expect']=le.fit_transform(data['Expect'])
data['Avenue']=le.fit_transform(data['Avenue'])
data['What are your savings objectives?']=le.fit_transform(data['What are your savings objectives?'])
data['Reason_Equity']=le.fit_transform(data['What are your savings objectives?'])
data['Reason_Mutual']=le.fit_transform(data['Reason_Mutual'])
data['Reason_Bonds']=le.fit_transform(data['Reason_Bonds'])
data['Reason_FD']=le.fit_transform(data['Reason_FD'])
print(data)
X=data[['gender','age','Investment_Avenues']]

# 0 is female
mutual_funds = pickle.load(open('Mutual_Funds','rb'))
Equity_Market = pickle.load(open('Equity_Market','rb'))
Government_Bonds = pickle.load(open('Government_Bonds','rb'))
Fixed_Deposits = pickle.load(open('Fixed_Deposits','rb'))
Ppf = pickle.load(open('PPF','rb'))
Gold = pickle.load(open('Gold','rb'))
sex = 0
age = 27
data = {"gender":[sex],"age":[age],"Investment_Avenues":[1]}
res = mutual_funds.predict(pd.DataFrame(data))
print(res[0])