N=int(input()) #별N개찍기
for i in range(1,N+1):
    space=N-i
    print(" "*space+"*"*i)