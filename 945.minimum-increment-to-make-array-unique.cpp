/*
 * @lc app=leetcode id=945 lang=cpp
 *
 * [945] Minimum Increment to Make Array Unique
 */

// @lc code=start
class Solution {
public:
    int minIncrementForUnique(vector<int>& A) {
        if(A.size()<1)return 0;
        vector<int> vec(A);
        sort(vec.begin(),vec.end());
        int res = 0, t = vec[0];
        for (int a: vec ) {
            res += max(t - a, 0);
            t = max(a, t)+1;
        }
        return res;
    }
};
// @lc code=end

