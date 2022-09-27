#while 반복문
while True: #무한루프
    try:
        A,B=map(int,input().split())
        print(A+B)
    except:
        break