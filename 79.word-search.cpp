/*
 * @lc app=leetcode id=79 lang=cpp
 *
 * [79] Word Search
 */

// @lc code=start
class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        int size=strlen(word);
        for(auto &&r : board)
        {
            for (auto &&i : board)
            {
                if(!size)return true;
                for (int j = 0; j < strlen(word); j++)
                {
                    if(word[j])if (word[j]==i)
                    {
                        word[i]=0;
                        size--;
                    }
                }
            }
        }
        return false;
    }
};
// @lc code=end

