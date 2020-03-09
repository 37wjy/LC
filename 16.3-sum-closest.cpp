/*
 * @lc app=leetcode id=16 lang=cpp
 *
 * [16] 3Sum Closest
 */

// @lc code=start
class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        if (nums.size()<=2)
        {
            return 0;
        }
        sort(nums.begin(),nums.end());
        int min=nums[0]+nums[1]+nums[2];
        for (int s = 0; s < nums.size()-2; s++)
        {
            if (s>0&&nums[s]==nums[s-1]) continue;
            int l=s+1,r=nums.size()-1;
            while (l<r)
            {
                int tmp=nums[s]+nums[l]+nums[r];
                if(tmp==target)
                return target;
                if (abs(tmp-target)<abs(min-target))
                    min=tmp;
                else if (tmp<target)
                {
                    l++;
                }
                else
                {
                    r--;
                }
            }
        }
        return min;
    }
};
// @lc code=end

