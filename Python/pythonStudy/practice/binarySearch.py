
def binarysearch(mylist, find, start , stop):
    if start > stop:
        return False
    else:
        mid = (start + stop) // 2
        if find == mylist[mid]:
            return mid
        elif find < mylist[mid]:
            return binarysearch(mylist , find , start , mid -1)
        else:
            return binarysearch(mylist , find, mid +1 ,stop)



mylist = [10 ,12 ,13, 15 ,20 , 24 , 27 , 33 , 42 , 51 ,57 ,68 ,70 ,77 ,79, 81]
find = 42
start = 0
stop = len(mylist)

x = binarysearch(mylist, find , start , stop)

if x == False:
    print("error", find , "not found ")
else:
    print("item" , find , "found" , x )