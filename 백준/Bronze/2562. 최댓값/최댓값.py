n_list=[]
for i in range(9):
    n_list.append(int(input())) #9개의 숫자 받아오기
print(max(n_list)) 
print(n_list.index(max(n_list))+1) #인덱스값 +1
