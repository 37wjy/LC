/*
 * @lc app=leetcode id=53 lang=cpp
 *
 * [53] Maximum Subarray
 */

// @lc code=start
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int all=nums[0], loc= nums[0];
        for (int i = 1; i < nums.size(); i++)
        {
            loc=max(loc+nums[i],nums[i]);
            all=max(all,loc);
        }
        return all;
    }
};
// @lc code=end

