# Recursion function - функція яка викликає сама себе 


def hello(x): 
    if x == 0:
        return
    else:
        print("Hello worls")
        hello(x-1)
   

hello(10) # else буде повторюватись поки x не дійде до 0 


def sum(x):
    if x == 0:
        return 0
    if x == 1:
        return 1
    else:
        return x + sum(x-1)

r  = sum(5)
print(r)


def factorial(x):                        #return 1 
    if x == 0:                           # return 1x1 = 1
        return 1                         # return 2x1 = 2
    else:                                # return 3x2 = 6
        return x * factorial(x-1)        # return 4x6 = 24

print(factorial(5))

def fibo(x):
    if x == 0:
        return 0
    elif x == 1:
        return 1
    else:
        return fibo(x-1) + fibo(x-2)


print(fibo(10))