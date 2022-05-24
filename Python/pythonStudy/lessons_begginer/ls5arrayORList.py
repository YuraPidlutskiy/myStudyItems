cities = ['New York' , 'Kiev' , 'Odesa', 'Lviv', 'Panama']
print(cities)
print(len(cities)) # довжина масива 
print(cities(0)) # перший номер в масиві тут рахунок починається з 0 
print(cities(-1)) # виведе останній номер в масива 
print(cities(-2)) # виведе передостанній тобто lviv

cities[2] = 'Tronto' # змінить на вказаній позиції 
cities.append('Kruzak') # добавить нове значення в масив 
cities.insert(2,'Xerson') # добавить слово на вибрану позицію  

del cities[-1]  # видалить люде вибране значення  
cities.remove("Kiev") # видалить описення в душках значення 
deleted.city = cities.pop() #--------
cities.sort() # посортує масив 
cities.reverse() # задом наперед
#---------------------------Part2----------------------------------#
cars = ['bmv','lada','toyou','']

cars = ['bmv' , "audi" , "toyuta" , "faw"]
for x in cars:
    print(x.upper())