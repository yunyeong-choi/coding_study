#정렬 후 str join
def solution(n):
    n_list=list(map(int,str(n)))
    new_list=sorted(n_list, reverse = True)
    str_list=[str(i) for i in new_list]
    answer=''.join(str_list)
    return int(answer)