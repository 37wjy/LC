/*
 * @lc app=leetcode id=66 lang=cpp
 *
 * [66] Plus One
 */

// @lc code=start
class Solution {
public:
    vector<int> plusOne(vector<int>& digits) {
        int rem=1;
        if (digits.size())
        for (int i = digits.size() - 1; i >= 0&&rem; i--)
        {
            digits[i]++;
            rem=digits[i]/10;
            digits[i]%=10;
        }
        if (rem)
        {
            digits.insert(digits.begin(),1);
        }
        return digits;
    }
};
// @lc code=end

