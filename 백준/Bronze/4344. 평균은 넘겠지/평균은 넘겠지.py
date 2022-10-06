C= int(input()) #테스트케이스 개수

for i in range(C):
  n_list=list(map(int,input().split())) #첫번째 수는 명수 
  n_mean=sum(n_list[1:])/n_list[0] #각 줄의 평균
  cnt_student=0 #평균을 넘는 학생명수 초기값
  for j in n_list[1:]: #맨앞 학생수 제외
    if j>n_mean:
      cnt_student+=1
  result=(cnt_student/n_list[0])*100
  print(f'{result:.3f}%')
      




