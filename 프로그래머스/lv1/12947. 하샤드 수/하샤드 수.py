def solution(x):
    x_sum=0#자릿수의 합 초기값
    x_str=str(x)
    for i in range(len(x_str)):
        x_sum+=int(x_str[i])
    if x%x_sum==0:
        return True
    else:
        return False