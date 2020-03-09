/*
 * @lc app=leetcode id=48 lang=cpp
 *
 * [48] Rotate Image
 */

// @lc code=start
class Solution {
public:
    void rotate(vector<vector<int>>& matrix) {
        int n=matrix.size()-1;
        for (int i = 0; i < ceil(matrix.size()/2.0); i++)
        {
            for (int j = 0; j < matrix[i].size()/2; j++)
            {
                auto tmp=matrix[i][j];
                matrix[i][j]=matrix[n-j][i];
                matrix[n-j][i]=matrix[n-i][n-j];
                matrix[n-i][n-j]=matrix[j][n-i];
                matrix[j][n-i]=tmp;
            }
            
        }
        
    }
};
// @lc code=end
