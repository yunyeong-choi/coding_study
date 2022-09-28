import math

def solution(n):
    x=math.sqrt(n) #n의 제곱근

    if n%x==0:
          answer=(x+1)**2
    else:
          answer=-1
    return answer