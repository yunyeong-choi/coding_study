T= int(input()) #테스트케이스개수
for i in range(1,T+1):
    A,B=map(int,input().split())
    print("Case #%s: %s + %s = %s"%(i,A,B,A+B))