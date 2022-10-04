n_list=[]
result=[]
for i in range(10):
    n_list.append(int(input()))
    result.append(n_list[i]%42)
print(len(set(result))) #중복제거한 리스트 길이
    