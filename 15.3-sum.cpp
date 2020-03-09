#include <vector>
#include <iostream>

#include <algorithm>

/*
 * @lc app=leetcode id=15 lang=cpp
 *
 * [15] 3Sum
 */


//以和判定，左右收缩
// @lc code=start
<<<<<<< HEAD

using namespace std;
class Solution {
=======
class Solution
{
>>>>>>> 76af2e8091e2538d3057d0921a68147704dc848f
public:
    vector<vector<int>> threeSum(vector<int> &nums)
    {
        vector<vector<int>> triplets;
        int n = nums.size();
        sort(nums.begin(), nums.end());
<<<<<<< HEAD
        vector<int>tmp;
        Sum(Solution,nums,tmp,0,0);
        return Solution;
    }

    void Sum(vector<vector<int>>& Solution,vector<int>& nums,vector<int>& arr,int pos,int sum){
        if (pos>=nums.size()-1)
        {
            return;
        }
        for (; pos < nums.size(); pos++)
        {
            if(arr.size()==2){
                if (sum==-nums[pos])
                {
                    arr.push_back(nums[pos]);
                    Solution.push_back(arr);
                    arr.pop_back();
                    return;
                }
            continue;
            }
            if(nums[pos]==nums[pos+1]){
                for (;nums[pos]==nums[pos+1] ; pos++){};
                if (arr.size()==1)
                {
                    if (sum+2*nums[pos])
                    {
                        return;
                    }
                    arr.push_back(nums[pos]);
                    arr.push_back(nums[pos]);
                    Solution.push_back(arr);
                    arr.pop_back();
                    arr.pop_back();return;
                }
                arr.push_back(nums[pos]);
                Sum(Solution,nums,arr,pos+1,sum+nums[pos]);
                arr.push_back(nums[pos]);
                Sum(Solution,nums,arr,pos+2,sum+2*nums[pos]);
                arr.pop_back();
                arr.pop_back();
                continue;
            }
            arr.push_back(nums[pos]);
            Sum(Solution,nums,arr,pos+1,sum+nums[pos]);
            arr.pop_back();
        }
    }
};


 int main(int argc, char const *argv[])
{
    vector<int> a{-1,0,1,2,-1,-4};
    Solution s;
    vector<vector<int>> sol=s.threeSum(a);
    for (auto a:sol)
    {
        for (auto b: a)
        {
            cout<<b<<'\t';
        }
        cout<<endl;
    }
    
    return 0;
}  

// @lc code=end
=======
        for (int i = 0; i < n; i++)
        {
            if (!(i == 0 || nums[i] != nums[i - 1]))
                continue;
            int need = -nums[i];
            int l = i + 1, r = n - 1;
            while (l < r)
            {
                if (nums[l] + nums[r] == need)
                {
                    triplets.push_back({nums[i], nums[l], nums[r]});
                    r--;
                    while (r > l && nums[r] == nums[r + 1])
                        r--;
                }
                else if (nums[l] + nums[r] < need)
                {
                    l++;
                }
                else
                {
                    r--;
                }
            }
        }
        return triplets;
    }
};
>>>>>>> 76af2e8091e2538d3057d0921a68147704dc848f

// @lc code=end
