#include <vector>
#include <iostream>

#include <algorithm>

/*
 * @lc app=leetcode id=15 lang=cpp
 *
 * [15] 3Sum
 */

// @lc code=start

using namespace std;
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> Solution;
        if(nums.size()<3) return vector<vector<int>>{};
        sort(nums.begin(), nums.end());
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

