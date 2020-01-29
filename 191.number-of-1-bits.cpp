/*
 * @lc app=leetcode id=191 lang=cpp
 *
 * [191] Number of 1 Bits
 */
#include<iostream>
using namespace std;
// @lc code=start
class Solution {
public:
    int hammingWeight(uint32_t n) {
        int j=0;
        for (int i = 0; i <= 31&&n!=0; i++)
        {
            if((n>>i)&1){
                j++;
            }
        }
        return j;
    }
};
// @lc code=end

