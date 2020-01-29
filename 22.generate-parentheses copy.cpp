/*
 * @lc app=leetcode id=22 lang=cpp
 *
 * [22] Generate Parentheses
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    vector<string> generateParenthesis(int n){
        if(n<=0)return vector<string>{};
        vector<string> tmps,res{""};
        vector<int> tmpn,resn{0};
        for(int i=0;i<2*n;i++){
            tmps.clear();
            tmpn.clear();
            for(int j=0;j<res.size();j++){
                if(((2*n-i-resn[j])/2)>0){
                    tmps.push_back(res[j]+'(');
                    tmpn.push_back(resn[j]+1);
                }
                if(resn[j]>0){
                    tmps.push_back(res[j]+')');
                    tmpn.push_back(resn[j]-1);
                }
            }
            swap(tmps,res);
            swap(tmpn,resn);
        }
        return res;
    }
};
// @lc code=end

