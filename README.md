# oofinance

* Abstract:
This paper revolves around our solution for HackNiche, the hackathon held by DJSCE. Our solution relies on the 50-30-20 rule of investing.
We have discussed our thought process and architecture along with relevant maths and theory. 

## Requirements and suggested features:
The requirements as stated in the circular by the organizers was as follows
The solution can involve different saving strategies for different types of users based on features like income,living expenses, etc.
You may involve different government investment schemes like Public Provident Funds, Government Securities, Sovereign Gold Bonds, National Savings Certificate, National Pension Schemes, and Post Office Monthly Income Schemes.
Suitable insurance plans may be considered for proper insurance coverage.
Stock suggestions on the basis of the current portfolio and its potential growth may earn brownie points.
Your solution may involve emergency funds, dream funds, retirement planning, and easy liquidity of assets for a complete solution.
As stated before,we decided to focus on the 50 30 20 investing rule during the 24 hours available to us to complete working.

## Expected return on investment:
The 1st step we decided on was understanding how we gain a returns on investments. This lead us to the equation for the expected return on investments, as shown below

![image](https://user-images.githubusercontent.com/52862591/219943292-1fc9467e-175c-411b-a86e-0df2ed50e048.png)

Where Wi is the weight of the ith asset and Ei is the expected returns. However, we need to ensure good financial planing. This can only be ensured by saving adequately and consistently. We address this in the next section

### FU Money!
The concept of Fu Money, in our context is the money that should be kept aside at all times, easily accessible and which should not be used under any circumstances except for an emergency! 

More formally, 
We can define FuMoney as a function of the risk appetite of a person and their annual income
```
FuMoeny = f(r,Income)

where r is risk factor and Income is the monthly income of the user. 

When ActualFuMoney<TargetFuMoney

f(r,Income;idealRate) = | Income*idealRate-r*c | 

where c is

C = TargetFuMoney - ActualFuMoney 

```

Else if the current money in the account is greater than the FuMoney limit, we adjust the formula to account for inflation as 

```
f(r,Income;inflation) = | Income*inflation |
```

### What about risk?
We added the additional constant r, which we have called the risk appetite to account for individuals willing to take a higher risk, thus which will affect the suggested percentages.


### Ensemble methods with MLP
Given the lack of quality data, we have had to make do with data available in the time span and implemented a mixture of Multilayer Perceptron and Bagging to arrive at a score. Bagging, also known as bootstrap aggregation, is the ensemble learning method that is commonly used to reduce variance within a noisy dataset. 


An example multi layer perceptron is shown above

![image](https://user-images.githubusercontent.com/52862591/219942026-7467e66c-2c17-4f2a-837f-d352f9dae131.png)

In bagging, a random sample of data in a training set is selected with replacement—meaning that the individual data points can be chosen more than once.

A diagram of how Bagging works

![image](https://user-images.githubusercontent.com/52862591/219942003-2e3ea8aa-13b9-42cd-b3a5-20dee98143fe.png)
<br>
We trained individual MLP models to classify different investment strategies based on the given way the market is behaving, historic performances and risk appetite of the user as well as of the market. This was the most challenging part of our solution, the reason being that the datasets we had at our disposal did not have adequate data to train the model without it incurring excessive overfitting. We tried to minimize the effects of this using Bagging. In our case, this data was then normalized against the aggregate of the predicted values of other models to return the optimal percentage distribution across various classes.

### Suggesting products
The problem of suggesting financial products/instruments in our system is a Laplace maximization problem. We want to maximize our returns while minimizing the risk we take onboard. Risk is a function of the price and the credit rating of the respective products.
```
Risk = r(price,creditRating)
```
We then go down the derivation using Laplace’s equation to arrive at
```
L(X;W,Risk) = ( || WTX||)/2 - Risk = LinkelyReturns
```
We can thus now use this formula along with the formula derived earlier to filter out appropriate products.

### How did we stitch it all together?
Below is the flow diagram of our system.

![image](https://user-images.githubusercontent.com/52862591/219942191-49835650-4f55-455e-a1c2-1ac0519202a8.png)

* Step 1: The user sends a request to the API endpoint with the required data
* Step 2: We validate the data passed to the model and use it make a prediction
* Step 3: Since we are using Bagging, we normalize the results of each individual model and return an aggregate result
* Step 4: We now use this prediction to take the required data from the Database
* Step 5: We now pass this data back to the client to be rendered

### How did we deploy it?
The cloud architecture diagram

![image](https://user-images.githubusercontent.com/52862591/219942217-28142e07-25c1-47c1-96c7-2d61caa479dc.png)

We used GCP to deploy our project using Docker containers to prevent any dependency issues. To ensure that we have no outage, we used a docker swarm to ensure that we have no issues with outages

## Conclusion:
Sure we didn’t win, but we learnt a lot about using Deep-Learning in finance. We were able to predict the likelihood of user preferences, thus allowing us to suggest good portfolio distributions as well as good investment instruments while taking into account historic metrics and the user’s risk appetite. 


There is still a lot more left to write on this, but I'll leave it at this. This was written and built with love and a whole lot of coffee!   :) 

### References:
https://en.wikipedia.org/wiki/Multilayer_perceptron
Dataset1: https://www.kaggle.com/datasets/nitindatta/finance-data?select=Finance_data.csv
Dataset2: https://www.kaggle.com/datasets/uciml/adult-census-income
Dataset3: https://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPClassifier.html
GitHub implementation: 
