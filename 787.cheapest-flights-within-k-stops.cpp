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
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        vector<vector<int>> vec(n);
        queue<vector<int>> q;
        build(flights,vec);
        q.push({src,0});    
        int res=INT32_MAX;
        for (int i = 0; i <= k+1; i++)
        {
            int size=q.size();
            for (int j = 0; j < size; j++)
            {
                int tmp=q.front()[0];
                int price=q.front()[1];
                q.pop();
                if (tmp==dst)
                {
                    res=min(price,res);
                    continue;
                }
                
                for (int k = 0; k < (vec[tmp].size()/2); k++)
                {
                    q.push({vec[tmp][2*k],vec[tmp][2*k+1]+price});
                    
                }
            }
            
        }
        return res==INT32_MAX?-1:res;
    }
    void build(vector<vector<int>>& flights,vector<vector<int>>& vec){
        for (int i = 0; i < flights.size(); i++)
        {
            vec[flights[i][0]].push_back(flights[i][1]);
            vec[flights[i][0]].push_back(flights[i][2]);
        }
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

