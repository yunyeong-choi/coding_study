#def solution(arr):
#    answer = sum(arr)/len(arr)
#    return answer



def solution(arr):
    sum=0
    len=0
    for i in arr:
        sum+=i
    for j in arr:
        len+=1
    answer = sum/len
    return answer