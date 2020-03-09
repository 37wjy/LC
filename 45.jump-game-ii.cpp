/*
 * @lc app=leetcode id=45 lang=cpp
 *
 * [45] Jump Game II
 */

// @lc code=start
class Solution {
public:
    int jump(vector<int>& nums) {
        int stp=0,ed=0,op=0;
        for (int i = 0; i < nums.size()-1; i++)
        {
            op=max(op,i+nums[i]);
            if(i==ed){
                stp++;
                ed=op;
            }
        }
        return stp;
    }
};
// @lc code=end

