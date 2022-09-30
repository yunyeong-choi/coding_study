def solution(n):
    answer = []
    num_str=str(n) #숫자를 문자화
    for i in range(1,len(num_str)+1):
        answer.append(int(num_str[-i])) #다시 정수화
    return answer