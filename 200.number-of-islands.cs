/*
 * @lc app=leetcode id=200 lang=csharp
 *
 * [200] Number of Islands
 */

// @lc code=start
public class Solution {
    public int NumIslands(char[][] grid) {
        int islands = 0;
        for (int i=0; i<grid.Length; i++)
            for (int j=0; j<grid[i].Length; j++)
                islands += sink(ref grid, i, j);
        return islands;
    }
    int sink(ref char[][] grid, int i, int j) {
        if (i < 0 || i == grid.Length|| j < 0 || j == grid[i].Length || grid[i][j] == '0')
            return 0;
        grid[i][j] = '0';
        for (int k=0; k<4; k++)
            sink(ref grid, i+d[k], j+d[k+1]);
        return 1;
    }
    int[] d = {0, 1, 0, -1, 0};
}
// @lc code=end

