X=int(input()) # 영수증금액
N=int(input()) #영수증에 적힌 물건의 종류수
result=0

for i in range(N):
    a,b=map(int,input().split()) #a:물건가격,b:물건개수
    result+=a*b
if result==X:
    print('Yes')
else:
    print('No')
    