/*
 * @lc app=leetcode id=787 lang=cpp
 *
 * [787] Cheapest Flights Within K Stops
 */
#include <iostream>
#include <queue>
#include <vector>
using namespace std;


// @lc code=start
class Solution {
public:
    //bellman ford.
    //just run it k+1 iterations.
    int findCheapestPrice(int n, vector<vector<int>>& a, int src, int sink, int k) {
        
        vector<int> c(n, 1e8);
        c[src] = 0;
        
        for(int z=0; z<=k; z++){
            vector<int> C(c);
            for(auto e: a)
                C[e[1]] = min(C[e[1]], c[e[0]] + e[2]);
            c = C;
        }
        return c[sink] == 1e8 ? -1 : c[sink];
    }
};

/* int main(int argc, char const *argv[])
{
    vector<vector<int>> fl{{0,1,100},{1,2,100},{0,2,500}};
    Solution s;
    cout<<s.findCheapestPrice(3,fl,0,2,1);
    return 0;
}
 */
// @lc code=end

