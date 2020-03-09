#
# @lc app=leetcode id=884 lang=python3
#
# [884] Uncommon Words from Two Sentences
#

# @lc code=start
class Solution:
    def uncommonFromSentences(A, B) :
        sl1=A.split(" ")
        sl2=B.split(" ")
        dic={}
        for i in sl1:
            if dic.get(i)==None:
                dic[i]=0
            dic[i]=dic[i]+1
        for i in sl2:
            if dic.get(i)==None:
                dic[i]=0
            dic[i]=dic[i]+1
    
        
        re=list (dic.keys()) [list (dic.values()).index (1)]
        return re
        #min(dic, key=dic.get)
# @lc code=end

s1="this apple is sweet"
s2="this apple is sour"

s=Solution
s.uncommonFromSentences(s1,s2)