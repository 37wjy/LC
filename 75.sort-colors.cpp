/*
 * @lc app=leetcode id=75 lang=cpp
 *
 * [75] Sort Colors
 */

// @lc code=start
class Solution {
public:
    void sortColors(vector<int>& nums) {
        int cnt;
        do
        {   
            cnt=0;
            for (int i = 0; i < nums.size()-1; i++)
            {
                if (nums[i]>nums[i+1])
                {
                    cnt++;
                    for (int j = nums.size() - 1; j >i; j--)
                    {
                        if(nums[j]<nums[i]){int tmp=nums[j];nums[j]=nums[i];
                        nums[i]=tmp;
                        cout<<nums[j]<<" "<<nums[i]<<endl;
                        }
                        
                    }
                }
            }
        }while (cnt!=0);
    }
};
// @lc code=end

