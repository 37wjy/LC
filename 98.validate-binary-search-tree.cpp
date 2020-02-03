/*
 * @lc app=leetcode id=98 lang=cpp
 *
 * [98] Validate Binary Search Tree
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
    int pre;
    bool first=true;
    bool isValidBST(TreeNode* root) {
        return judg(root);
    }

    bool judg(TreeNode* root){
        if (root==nullptr)
        {
            return true;
        }
        if(!judg(root->left))
            return false;
        if(first){
            pre=root->val;
            first=false;
        }
        else if (pre>=root->val)
        {
            return false;
        }
        pre=root->val;
        return judg(root->right);
    }
};
// @lc code=end

