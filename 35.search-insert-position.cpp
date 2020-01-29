/*
 * @lc app=leetcode id=35 lang=cpp
 *
 * [35] Search Insert Position
 */
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        int i=0;
        for (; i < nums.size(); i++)
        {
            if(target<=nums[i]){
                break;
            }
        }
        return i;
    }
};
// @lc code=end

