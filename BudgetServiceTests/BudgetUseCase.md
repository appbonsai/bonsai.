#  Budget base
- create 
- read
- update 
- delete 

#  Budget calculation 
- calculate budget very time when user spent money 
- calculate budget how much money user can spend today 


#  Budget terminology
1. ML  - Money left
2. MCS - Money can spend today
3. UMS - User Money spend input(user input transaction how much money he spent)
4. TA  - Total Amount
5. P   - Period days
6. CA  - Current Amount

#  Budget Formulas

1. Calculate how much money user can spend daily
- MCS = CA / P 
2. Calculate how much total money user left
- ML = TA - CA
3. Calculate how much CA left after spending user input
- CA = CA - UMS
