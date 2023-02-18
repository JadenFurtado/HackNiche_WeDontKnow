""" inputData = {
    'age':20,
    'Income':400000,
    "risk":"MEDIUM",
    'rules':[
            {
                'rule_id':1,
                'rule_name':'FuMoney Limit',
                'Account':"account_id",
                'Type':'Limit',
                'Rule':"more than",
                'Val':20000,
                'Recurrence':'Indefinite'
            },
            {
                'rule_id':2,
                'rule_name':'Securities Limit',
                'Account':"account_id",
                'Type':'Invest',
                'Rule':"less than",
                'Val':10000,
                'Recurrence':'Monthly'
            }
        ]
    } """
inputData = {
    'age':20,
    'Income':400000,
    'risk':0.5,
    'expenses':100000,
    'fuActual':200000,
    'fuTarget':100000,
    'InflationRate':5
}


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from collections import Counter

from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier, GradientBoostingClassifier, ExtraTreesClassifier, VotingClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import GridSearchCV, cross_val_score, StratifiedKFold, learning_curve, train_test_split, KFold
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score

dataset = pd.read_csv("/home/jaden/Downloads/Finance_data.csv")

# Check for Null Data
nullData = dataset.isnull().sum()

print(nullData)

# Replace All Null Data in NaN
dataset = dataset.fillna(np.nan)
print(dataset.describe().T)