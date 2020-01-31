/*

You are given a square board of characters. You can move on the board starting at the bottom right square marked with the character 'S'.

You need to reach the top left square marked with the character 'E'. The rest of the squares are labeled either with a numeric character 1, 2, ..., 9 or with an obstacle 'X'. In one move you can go up, left or up-left (diagonally) only if there is no obstacle there.

Return a list of two integers: the first integer is the maximum sum of numeric characters you can collect, and the second is the number of such paths that you can take to get that maximum sum, taken modulo 10^9 + 7.

In case there is no path, return [0, 0].

Example 1:

Input: board = ["E23","2X2","12S"]
Output: [7,1]

Example 3:

Input: board = ["E11","XXX","11S"]
Output: [0,0]

*/


/*
dp[i][j] := 
count[i][j] := 

m = max(dp[i + 1][j], dp[i][j+1], dp[i+1][j+1])
dp[i][j] = board[i][j] + m
count[i][j] += count[i+1][j] if dp[i+1][j] == m
count[i][j] += count[i][j+1] if dp[i][j+1] == m
count[i][j] += count[i+1][j+1] if dp[i+1][j+1] == m
*/
class Solution {
    public int[] pathsWithMaxScore(List<String> board) {
        int MOD = (int)(1e9 + 7);
        int m = board.size(), n = board.get(0).length();
        int[][] dp = new int[m+1][n+1];     //max score when reach (j, i)
        int[][] count = new int[n+1][n+1];  //path to reach (j, i) with max score
        count[n-1][n-1] = 1;
        for(int i = m-1;i>=0;i--)
            for(int j = n-1; j>=0;j--){
                char c= board.get(i).charAt(j);
                if(c!='X'){
                    int max = Math.max(Math.max(dp[i+1][j], dp[i][j+1]), dp[i+1][j+1]);
                    int num = c-'0';
                    if(c=='S' || c=='E') num = 0;
                    dp[i][j] = num + max;
                    if(dp[i+1][j] == max) count[i][j] = (count[i][j] + count[i+1][j]) % MOD;
                    if(dp[i+1][j+1] == max) count[i][j] = (count[i][j] + count[i+1][j+1]) % MOD;
                    if(dp[i][j+1] == max) count[i][j] = (count[i][j] + count[i][j+1]) % MOD;
                }
            }
        
        return count[0][0] > 0 ? new int[]{dp[0][0], count[0][0]} : new int[]{0, 0};
    }
}