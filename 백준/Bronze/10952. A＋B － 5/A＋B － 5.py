#while 반복문
while True: #무한루프
    A,B=map(int,input().split())
    if A==0 and B==0:
        break; #테스트케이스 중단
    else:
        print(A+B)