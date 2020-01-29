/*
 * @lc app=leetcode id=154 lang=cpp
 *
 * [154] Find Minimum in Rotated Sorted Array II
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    int findMin(vector<int>& nums) {
        bool f=false;int i =0, j=nums.size();
        while (i<j)
        {
            if (nums[(i+j)/2]<=nums[i])
            {
                i=(i+j)/2;
            }
            else
            {
                j=(i+j)/2;
            } 
        }

        return nums[i];
    }
};
// @lc code=end

