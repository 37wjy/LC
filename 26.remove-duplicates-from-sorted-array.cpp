/*
 * @lc app=leetcode id=26 lang=cpp
 *
 * [26] Remove Duplicates from Sorted Array
 */
#include <vector>
#include <iostream>
using namespace std;
// @lc code=start
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if (!nums.size())
        {
            return 0;
        }
        int pre=nums[0],cnt=1;
        for (auto i = nums.begin()+1; i < nums.end();)
        {
            if(*i==pre){
                nums.erase(i);
            }
            else
            {
                pre=*i;
                i++;
            } 
        }
        
        return nums.size();
    }
};
/* 
int main(int argc, char const *argv[])
{
    Solution s;
    vector<int> vec{1,1,2};
    s.removeDuplicates( vec);
    for (auto &&i : vec)
    {
        cout<<i<<" ";
    }
    
    return 0;
} */

// @lc code=end

