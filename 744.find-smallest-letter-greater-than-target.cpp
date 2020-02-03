/*
 * @lc app=leetcode id=744 lang=cpp
 *
 * [744] Find Smallest Letter Greater Than Target
 */

// @lc code=start
class Solution {
public:
    char nextGreatestLetter(vector<char>& letters, char target) {
        for(char a:letters){
            if (a>target)
            {
                return a;   
            }
        }
        return letters[0];
    }
};
// @lc code=end

