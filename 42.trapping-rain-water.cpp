/*
 * @lc app=leetcode id=42 lang=cpp
 *
 * [42] Trapping Rain Water
 */

// @lc code=start
class Solution {
public:
    int trap(vector<int>& height) {
        if (!height.size()) return 0;
        
        int cnt=0,l=0,r=height.size()-1;
        while (r>l)
        {
            if (height[r]>height[l])
            {
                int high=height[l];
                for (++l; height[l]<high&&l < r; l++)
                {
                    cnt+=high-height[l];
                }
            }
            else
            {
                int high=height[r];
                for (--r;  height[r]<high && r > l; r--)
                {
                    cnt+=high-height[r];
                }
            }
        }
        return cnt;
    }
};
// @lc code=end

