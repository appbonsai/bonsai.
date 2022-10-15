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


# Обновления бюджета 
- Пример создан бюджет: на 10000 $ на 30 дней

- Мы знаем что считать нужно количество денег выделено на бюджет равно 10000 $, но считать сколько можно потратить в день только из тех денег которых осталось потому что пользователь может создавать новые транзакции  

- к примеру у юзера есть 10000 $ на 30 дней, если они ничего не ввел то в день он может тратить 10000 / 30 = 333.33 $

- если он все-таки ввел новую транзакцию на наркотики 1000 $, у него осталось 9000$ 

- каждый день можно тратить 9000/30 то есть 300 $ в день

- на следующий 9000/29 = 310,34

- на следующий 9000/28 = 310,34 итд

- # Условие: каждый раз когда пользователь заходит в приложение или же остается в нем при наступлении следующего дня обновлять правильно dailyBudget()
 
- # Задача: 
- Сохранять дату создания бюджета и проверять каждый раз текущую дату при запуске приложения или же при открытии экрана и считать dailyBudget()
- Обновлять dailyBudget() как только наступит следующий день с проверкой по Timezone

