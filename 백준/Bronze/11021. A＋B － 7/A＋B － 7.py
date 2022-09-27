T=int(input()) #테스트케이스개수

for x in range(1,T+1):
    A,B=map(int,input().split())
    print("Case #"+str(x)+": "+str(A+B))