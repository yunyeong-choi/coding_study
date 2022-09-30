def solution(s):
    p_cnt=0 #초기값 지정
    y_cnt=0 #초기값 지정
    try:  #'p', 'y' 모두 하나도 없는 경우 pass하고 항상 True 리턴

      for i in range(len(s)):
          if s[i]=='p'or s[i]=='P' : #대소문자구별X
              p_cnt+=1
          if s[i]=='y' or s[i]=='Y':
              y_cnt+=1
      if p_cnt==y_cnt:
          return True
      else :
          return False
    except:
      pass
    return True