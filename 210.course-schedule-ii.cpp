/*
 * @lc app=leetcode id=210 lang=cpp
 *
 * [210] Course Schedule II
 */
#include <vector>
#include <iostream>
using namespace std;
// @lc code=start
class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        
        graph g = buildGraph(numCourses, prerequisites); //存前置课程
        vector<int> degrees = computeIndegrees(g);
        vector<int> order;
        for (int i = 0; i < numCourses; i++) {
            int j = 0;
            for (; j < numCourses; j++) {
                if (!degrees[j]) {
                    order.push_back(j);
                    break;
                }
            }
            if (j == numCourses) {
                return {};
            }
            degrees[j]--;
            for (int v : g[j]) {
                degrees[v]--;
            }
        }        
        return order;
    }
private:
    typedef vector<vector<int>> graph;
    
    graph buildGraph(int numCourses, vector<vector<int>>& prerequisites) {
        graph g(numCourses);
        for (auto p : prerequisites) {
            g[p[1]].push_back(p[0]);
        }
        return g;
    }
    
    vector<int> computeIndegrees(graph& g) {
        vector<int> degrees(g.size(), 0);
        for (auto adj : g) {
            for (int v : adj) {
                degrees[v]++;
            }
        }
        return degrees;
    }
};
   

int main(int argc, char const *argv[])
{
    vector<vector<int>> sch={{1,0},{2,0},{3,1},{3,2}};
    Solution a;
    a.findOrder(4,sch);
    return 0;
}

// @lc code=end

