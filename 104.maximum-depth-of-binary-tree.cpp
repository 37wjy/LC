/*
 * @lc app=leetcode id=104 lang=cpp
 *
 * [104] Maximum Depth of Binary Tree
 */

// @lc code=start
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    int maxDepth(TreeNode* root) {
        int dp=0;
        
        return depth(root,dp);
    }

    int depth(TreeNode* root,int dp){
        if (root==nullptr)
        {
            return dp;
        }
        dp++;
        return max(depth(root->right,dp),depth(root->left,dp));
    }
};
// @lc code=end

