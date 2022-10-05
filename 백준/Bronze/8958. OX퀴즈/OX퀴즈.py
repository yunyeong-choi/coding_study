n=int(input())
test=[] #행단위로 테스트케이스  담을 빈리스트 
for i in range(n):
  test.append(list(str(input().split())))
  for j in range(len(test)):
    cnt=0 #o의 갯수초기값
    point=0 #점수의 초기값
    for k in range(len(test[j])):
      if test[j][k]=="O":
        cnt+=1
        point+=cnt
      elif  test[j][k]=="X":
        cnt=0
  print(point)