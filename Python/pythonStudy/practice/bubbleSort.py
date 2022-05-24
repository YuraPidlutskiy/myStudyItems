oldlist = [10, 75, 43, 15 ,-4 ,27]

def bubble_sort(mylist):
    last_item = len(mylist) -1
    for x in range(0, last_item):
        for y in range(0 , last_item -x):
            if mylist[y] > mylist[y+1]:
                mylist[y], mylist[y+1] = mylist[y+1], mylist[y]

    return mylist

print("oldlist",oldlist)
newlist = bubble_sort(oldlist).copy()
print("New List: " , newlist)