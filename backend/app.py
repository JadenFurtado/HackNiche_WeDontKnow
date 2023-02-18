import pickle
from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import json
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

app = Flask(__name__)

# income class


@app.route('/incomeClass')
def incomeClass(methods=['GET']):
    age = request.args.get('age')
    education = request.args.get('education.num')
    capital = request.args.get('capital.gain')
    loss = request.args.get('capital.loss')
    hours = request.args.get('hours.per.week')
    income = request.args.get('income')
    random_forest = pickle.load(open('model', 'rb'))
    res = random_forest.predict()
    return res
# 'Debentures','Government_Bonds','Fixed_Deposits','PPF','Gold'
# insurance policies and Emergency funds


@app.route('/diversifySuggestions')
def suggestions(methods=['GET']):
    age = request.args.get("age")
    income = request.args.get("income")
    sex = request.args.get("sex")
    riskScore = request.args.get("riskAppetite")
    if age is not None and income is not None and sex is not None:
        age = int(age)
        income = int(income)
        sex = int(sex)
        print(sex)
        print
        Debentures = pickle.load(open('models/Debentures', 'rb'))
        mutual_funds = pickle.load(open('models/Mutual_Funds', 'rb'))
        Equity_Market = pickle.load(open('models/Equity_Market', 'rb'))
        Government_Bonds = pickle.load(open('models/Government_Bonds', 'rb'))
        Fixed_Deposits = pickle.load(open('models/Fixed_Deposits', 'rb'))
        Ppf = pickle.load(open('models/PPF', 'rb'))
        Gold = pickle.load(open('models/Gold', 'rb'))
        data = {"gender": [sex], "age": [age], "Investment_Avenues": [1]}
        mutualFundsRation = mutual_funds.predict(pd.DataFrame(data))
        equityMarketRation = Equity_Market.predict(pd.DataFrame(data))
        govBonds = Government_Bonds.predict(pd.DataFrame(data))
        fdRation = Fixed_Deposits.predict(pd.DataFrame(data))
        goldRation = Gold.predict(pd.DataFrame(data))
        ppf = Ppf.predict(pd.DataFrame(data))
        debtRation = Debentures.predict(pd.DataFrame(data))
        net = mutualFundsRation+equityMarketRation + \
            govBonds+fdRation+ppf+goldRation+debtRation
        
        data = json.load(open('products.json'))
        resultData = {"pie_chart": {"equity_market": equityMarketRation[0]/net[0], "mutual_funds": mutualFundsRation[0]/net[0], "gov_bonds": govBonds[0] /
                      net[0], "fd": fdRation[0]/net[0], "gold": goldRation[0]/net[0], "ppf": ppf[0]/net[0], "debt": debtRation[0]/net[0]}, "products": {
                        "equity_market": data["equity_market"],
                        "gov_bonds": data["gov_bonds"],
                        "mutual_funds": data["mutual_funds"],
                        "fd": data["fd"]
                      }}
        # print(resultData, sum(resultData.values()))
        return jsonify(resultData)
    else:
        return '{"Error":"age or income or sex is null"}'


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000)
