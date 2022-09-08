i = int(input())
j = 2 # fix the code (1)
while (j <= (i/j)):
    if not(i%j):
        print("not a prime")
        break # fix the code (2)
    j = j + 1 # fix the code (3)
    print (j)
if (j > i/j):
    print ("prime")