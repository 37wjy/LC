/*
 * @lc app=leetcode id=78 lang=cpp
 *
 * [78] Subsets
 */
#include <iostream>
#include <vector>
using namespace std;

// @lc code=start
class Solution {
public:
    vector<vector<int>> subsets(vector<int>& nums) {
        vector<vector<int>> res{{}};
        if (nums.size()==0)
        {
            return res;
        }
        unsigned int j=1;
        for (int i = 1; i <=res.size() ; i++)
        {
            j*=i;
        }

        
    }
};
// @lc code=end

