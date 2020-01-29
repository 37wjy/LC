/*
 * @lc app=leetcode id=101 lang=csharp
 *
 * [101] Symmetric Tree
 */

 using System;

// @lc code=start
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public int val;
 *     public TreeNode left;
 *     public TreeNode right;
 *     public TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public bool IsSymmetric(TreeNode root) {
        if(root==null)return true;
        return r(ref root.left,ref root.right);
    }

    bool r(ref TreeNode ndl,ref TreeNode ndr){
        if(ndl==null&&ndr==null)return true;
        if(ndl==null||ndr==null) return false;
        bool re=(ndl.val==ndr.val);
        re=re&&r(ref ndl.right,ref ndr.left);
        re=re&&r(ref ndl.left,ref ndr.right);
        return re;
    }
}
// @lc code=end

