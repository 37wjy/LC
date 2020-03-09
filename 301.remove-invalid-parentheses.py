#
# @lc app=leetcode id=301 lang=python3
#
# [301] Remove Invalid Parentheses
#

# @lc code=start
class Solution:
    ans=[]
    def removeInvalidParentheses(self, s: str) -> List[str]:
        self.go(s,0,0,['(',')'])
        return self.ans

    def go(self,s,p,q,a):
        cnt=0
        for i in range(p,len(s)):
            if s[i]==a[0]:
                cnt+=1
            if s[i]==a[1]:
                cnt-=1
            if cnt>=0:
                continue
            else:
                for j in range(q,i):
                    if s[j]==a[1] and j==q or s[j-1] != a[1] :
                        self.go(s[0:j]+s[j+1:],i,j,['(',')'])
            return
        s1=''.join(reversed(s))

        if s[0]==')':
            self.go(s1,0,0,[')','('])
        else:
            self.ans.append(s)

            
# @lc code=end

