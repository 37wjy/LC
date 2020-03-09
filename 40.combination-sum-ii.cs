/*
 * @lc app=leetcode id=40 lang=csharp
 *
 * [40] Combination Sum II
 */
 using System;


// @lc code=start
public class Solution {
    public IList<IList<int>> CombinationSum2(int[] candidates, int target) {
        IList<IList<int>> ans=new Iist<IList<int>>();
        IList<int> q=new IList<int>();
        recurs(ref candidates,0,target,ref ans, q);
        return ans;
    }

    void recurs(ref int[] candidates,int pos,int target,ref IList<IList<int>> ans, IList<int> q ) {
        if(target==0){
            ans.Add(q);
            return;
        }
        if(target<0)return;
        for (++pos; pos < candidates.Length; pos++)
        {
            q.Add(candidates[pos]);
            recurs(ref candidates,pos,target+candidates[pos],ref ans, q);
            q.RemoveAt(q.Length-1);
        }
    }
}
// @lc code=end

