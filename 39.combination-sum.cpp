/*
 * @lc app=leetcode id=39 lang=cpp
 *
 * [39] Combination Sum
 */
#include <iostream>
#include <vector>
#include<algorithm>
using namespace std;
// @lc code=start
class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        if (candidates.size()<=0)
        {
            return vector<vector<int>>{};
        }
        sort(candidates.begin(),candidates.end());
        if (candidates[0]>target)
        {
            return vector<vector<int>>{};
        }
        vector<vector<int>> res;
        vector<int> tmp{};
        aaa(res,candidates,tmp,0,target);
        return res;
    }

    void aaa(vector<vector<int>> &res,vector<int>& candidates,vector<int> &crt,int pos,int sum){
        if(!sum){
            res.push_back(crt);
            return;
        }
        for (int i = pos; i < candidates.size(); i++)
        {
            vector<int> ca= crt;
            if (sum>=candidates[i])
            {
                ca.push_back(candidates[i]);
                aaa(res,candidates,ca,i,sum-candidates[i]);
            }
            else
            {
                return;
            }
        }  
    }
};
// @lc code=end

