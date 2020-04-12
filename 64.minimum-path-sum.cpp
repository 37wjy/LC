/*
 * @lc app=leetcode id=64 lang=cpp
 *
 * [64] Minimum Path Sum
 */

// @lc code=start
class Solution {
public:
    int minPathSum(vector<vector<int>>& grid) {
         vector<int> r(grid[0]);
         for (int i = 1; i < r.size(); i++)
         {
             r[i]+=r[i-1];
         }
         
         for (int i = 1 ; i < grid.size(); i++)
         {
             r[0]+=grid[i][0];
             for (int j = 1; j < r.size(); j++)
             {
                 r[j]=min(r[j-1]+grid[i][j],r[j]+grid[i][j]);
             }
         }
         return r[r.size()-1];
    }
};
// @lc code=end
