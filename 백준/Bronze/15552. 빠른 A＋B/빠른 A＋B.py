import sys
T=int(sys.stdin.readline()) #테스트케이스 개수

for i in range(T):
    A,B=map(int,sys.stdin.readline().split())
    print(A+B)