#
# @lc app=leetcode id=41 lang=python
#
# [41] First Missing Positive
#

# @lc code=start
class Solution(object):
    def firstMissingPositive(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        if len(nums)<=1:
            return len(nums)+1;
        for a in range(len(nums)):
            if nums[a]<0:
                return a;

        if nums[0]>nums[-1]:
            return len(nums)
        else :
            return 1
        
# @lc code=end

