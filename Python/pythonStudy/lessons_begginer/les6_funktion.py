

from cgi import print_environ


def napisati_privet():  # функція яка просто щось робить і викликається потім
    print("GG easy Darova")


def aaa():
    print("fff")

napisati_privet()
aaa()

def hello(name):     # функція яка приймає аргумент 
    print("gg easy katka for" + " " + name)


hello('Yura')

def summa(x,y):
    print(x+y)

summa(10,20)

def summa(g,i):
    return g+i

x = summa(22,33)
print(x)

def factorial(x):
    otvet = 1 
    for i in range(1, x + 1):
        otvet = otvet * i
    return otvet 


for i in range(1,10):
    print(str(i) + "!\t " + str(factorial(i)))


def create_record(name, telephone,addres):
    record = {
        'name': name,
        'telephone': telephone,
        'addres': addres
    }
    return record


user1 = create_record("yura" , "+38075848444" , "Lviv")
user2 = create_record("Vasya", "+3757859595", "Kiev")

print(user1)
print(user2)


def give_awards(medal,*persones):
    for persone in persones:
        print("Moya lybov " + persone.title() + " nagorodjuetsya medalyu " + medal)


give_awards("Za veliku sraku", "nastya" )
