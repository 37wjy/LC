/*
 * @lc app=leetcode id=162 lang=cpp
 *
 * [162] Find Peak Element
 */

// @lc code=start
class Solution {
public:
    int findPeakElement(vector<int>& nums) {
        for (int i = 0; i < nums.size()-1; i++)
        {
            if (nums[i]>nums[i+1])
            {
                return i;
            }
        }
        return 0;
    }
};
// @lc code=end

