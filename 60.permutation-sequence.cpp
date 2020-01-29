/*
 * @lc app=leetcode id=60 lang=cpp
 *
 * [60] Permutation Sequence
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    string getPermutation(int n, int k) {
        string res="";
        vector<bool> set(n);
        k--;
        for (int i = n-1; i >=0; i--)
        {
            int rem=frac(i);
            int tmp=k/rem;
            k%=rem;
            for(int j=tmp,k=0;j>=0&&k<n;k++){
                if(set[k]){
                    tmp++;
                }
                else{
                    j--;
                }   
            }
            res+=('1'+tmp);
            set[tmp]=true;
        }
        return res;
    }

    int frac(int n){
        if(n==1){
            return 1;
        }
        if(n==0)return INT32_MAX;
        return n*frac(n-1);
    }
};
// @lc code=end

