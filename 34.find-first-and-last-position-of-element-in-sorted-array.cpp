/*
 * @lc app=leetcode id=34 lang=cpp
 *
 * [34] Find First and Last Position of Element in Sorted Array
 */

// @lc code=start
class Solution {
public:
    vector<int> searchRange(vector<int>& nums, int target) {
        vector<int> ans{-1,-1};
        for (int i = 0; i < nums.size(); i++)
        {
            if (nums[i]==target)
            {
                if (ans[0]==-1)
                {
                    ans[0]=i;
                }
                ans[1]=i;
            }
        }
        return ans;
    }
};
// @lc code=end

