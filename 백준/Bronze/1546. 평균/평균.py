N=int(input()) #시험과목 수
N_list=list(map(int,input().split())) #시험점수 리스트 입력
result=[] #수정된 시험점수 담을 빈 리스트

for i in range(N):
    result.append((N_list[i]/max(N_list))*100)
print(sum(result)/N)
    