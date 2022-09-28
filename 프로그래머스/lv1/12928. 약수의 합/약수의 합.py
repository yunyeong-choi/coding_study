def solution(n):
    answer = 0
    for num in range(1,n+1):
        if n%num==0:
            answer+=num #약수의 합구하기
    
    return answer