/*
 * @lc app=leetcode id=74 lang=cpp
 *
 * [74] Search a 2D Matrix
 */

// @lc code=start
class Solution {
public:
    bool searchMatrix(vector<vector<int>>& matrix, int target) {

        for (int i = 0; i < matrix.size(); i++)
        {
            for (int j = matrix[i].size() - 1; j >= 0; j--)
            {
                if (matrix[i][j]<target)
                {
                    break;
                }
                if (matrix[i][j]==target)
                {
                    return true;
                }
            }
        }
        return false;
        
    }
};
// @lc code=end

