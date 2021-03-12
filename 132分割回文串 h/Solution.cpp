#include <iostream>
#include <vector>

using namespace std;

class Solution
{
public:
    int minCut(string s)
    {
        int n = s.size();

        // 两次遍历去构建字符串回文的动态规划
        bool **d = new bool *[n];
        for (int i = 0; i < n; ++i)
        {
            d[i] = new bool[n];
            for (int j = 0; j < n; ++j)
            {
                d[i][j] = true;
            }
        }
        // 从后往前去遍历
        for (int i = n - 1; i >= 0; --i)
        {
            for (int j = i + 1; j < n; ++j)
            {
                // 判断i和j是否相等，相等则扩展
                d[i][j] = (s[i] == s[j]) && d[i + 1][j - 1];
            }
        }

        // 构建最小分隔的动态规划
        int *f = new int[n];
        for (int i = 0; i < n; ++i)
        {
            f[i] = INT_MAX;
        }
        for (int i = 0; i < n; i++)
        {
            if (d[0][i])
            {
                f[i] = 0;
            }
            else
            {
                for (int j = 0; j < i; j++)
                {
                    if (d[j + 1][i])
                    {
                        f[i] = min(f[i], f[j] + 1);
                    }
                }
            }
        }
        return f[n - 1];
    }
};
