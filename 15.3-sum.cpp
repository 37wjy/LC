#include <unordered_map>
#include <vector>
#include <iostream>
using namespace std;
/*
 * @lc app=leetcode id=15 lang=cpp
 *
 * [15] 3Sum
 */

// @lc code=start
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> Solution;
        if(nums.size()<3) return vector<vector<int>>{};
        sort(nums.begin(), nums.end());
        int pre1=nums[0];
        for (uint32_t i = 0; i < nums.size()-2; i++)
        {
            for (uint32_t j = i+1; j < nums.size()-1&&(i==0 || nums[i]!=pre1); j++)
            {
                int pre2=nums[i+1];
                for (uint32_t k = j+1; k < nums.size()&&(j==i+1 || nums[j]!=pre2); k++)
                {
                    if(k!=j+1&&nums[k-1]==nums[k])continue;
                    cout<<(j==i+1 || nums[j]!=pre2)<<endl<<j<<i<<endl;
                    if(!(nums[i]+nums[j]+nums[k])){
                        Solution.push_back( vector<int>{nums[i],nums[j],nums[k]});  
                    }
                    pre2=nums[k];
                }
                
            }
            pre1=nums[i];
        }
        return Solution;
        
    }
};
// @lc code=end

