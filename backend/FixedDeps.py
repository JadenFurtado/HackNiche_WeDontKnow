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

# Spliting data into Feature and 
X=data[['gender','age','Investment_Avenues']]
y=data['Fixed_Deposits']
# ,'Equity_Market','Debentures','Government_Bonds','Fixed_Deposits','PPF','Gold'
# Import train_test_split function
from sklearn.model_selection import train_test_split

# Split dataset into training set and test set
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)  # 70% training and 30% test

# Import MLPClassifer 
from sklearn.neural_network import MLPClassifier

# Create model object
clf = MLPClassifier(hidden_layer_sizes=(14,10,7),
                    random_state=5,
                    verbose=True,
                    learning_rate_init=0.02,max_iter=600)

# Fit data onto the model
clf.fit(X_train,y_train)

# Make prediction on test dataset
ypred=clf.predict(X_test)
print(y_test)
print(ypred)
# Import accuracy score 
from sklearn.metrics import accuracy_score

# Calcuate accuracy
accuracy_score(y_test,ypred)

pickle.dump(clf,open('Fixed_Deposits','wb'))