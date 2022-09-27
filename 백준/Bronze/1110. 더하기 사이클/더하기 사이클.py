N=int(input())
result=N #변하는값
cnt=0 #사이클 길이 구하기 위한 초기값
while True:
    a=result//10 #10의자리값
    b=result%10 #1의자리값
    c=(a+b)%10
    result=(b*10)+c
    
    cnt=cnt+1 #사이클수
    if (result==N):
        break
    
print(cnt)