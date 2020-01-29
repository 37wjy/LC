/*
 * @lc app=leetcode id=153 lang=cpp
 *
 * [153] Find Minimum in Rotated Sorted Array
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    int findMin(vector<int>& nums) {
        int min=nums[0];
        for (int i = 1; i < nums.size(); i++)
        {
            if(nums[i-1]>nums[i]){
                return min>nums[i]?nums[i]:min;
            }
        }
        return min;
    }
};
// @lc code=end

