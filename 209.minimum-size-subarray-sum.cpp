/*
 * @lc app=leetcode id=209 lang=cpp
 *
 * [209] Minimum Size Subarray Sum
 */

// @lc code=start
class Solution {
public:
    int minSubArrayLen(int s, vector<int>& nums) {
        int f=INT_MAX,e=nums.size();
        for (int i = 0; i < nums.size(); i++)
        {
            int c=0;
            for (int k = i; k < abs(i+f)&&k<nums.size(); k++)
            {
                c+=nums[k];
                if (c>=s)
                {
                    f=(k-i)+1;
                }
            }
        }
        return f==INT_MAX?0:f;
    }
};
// @lc code=end

