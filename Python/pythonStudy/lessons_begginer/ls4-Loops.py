
for x in range(0,100):       # буде перебирати від 0 до 10 залежно від значення 
    print("********")        #3 значання (10(старрт) , 20(крок),3(крок))
    print("--------")
    print(x)

for x in range (-100,10,2):
    print("Number x = " + str(x))  # виведе результат в консоль 
    if x == 50:       # УМОВА ЩО Х ДІЙДЕ ДО 50 
        break         # -- ЗУПИНЯЄ ЦИКЛ 


a = 0           # даємо значення перемінній 
while True:     # викликаємо цикл 
    print(a)    # виводимо результат 
    a = a + 1   # добавляє +1 до кожного кроку те саме що а++
    if a == 100: # умова яка каже якщо а буде рівннятись 100 зупитинитимь
        break    #  функція яка зупинить цикл після того як виконається умова 