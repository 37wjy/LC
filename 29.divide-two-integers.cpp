/*
 * @lc app=leetcode id=29 lang=cpp
 *
 * [29] Divide Two Integers
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    int divide(int dividend, int divisor) {
    #define MaxPo 2147483648 

        bool positive = ((dividend > 0) && (divisor > 0)) || ((dividend < 0) && (divisor < 0));

        unsigned int tdividend;
        if (dividend == INT32_MIN) {
            tdividend = MaxPo;
        }
        else {
            tdividend = abs(dividend);
        }

        unsigned int tdivisor;
        if (divisor == INT32_MIN) {
            tdivisor = MaxPo;
        }
        else {
            tdivisor = abs(divisor);
        }

        unsigned int count = 1, result = 0;

        for (int i = 31; i >= 0; i--) {
            if ((tdividend >> i) >= tdivisor) {
                tdividend -= (tdivisor << i);
                result += (count << i);
            }
        }

        if (positive && result >= MaxPo) {
            return INT32_MAX;
        }

        result *= positive ? 1 : -1;
        return result;
    }
};
// @lc code=end

