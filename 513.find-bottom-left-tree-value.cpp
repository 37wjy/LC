/*
 * @lc app=leetcode id=513 lang=cpp
 *
 * [513] Find Bottom Left Tree Value
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
    int findBottomLeftValue(TreeNode* root) {
        if(root->left==NULL && root->right == NULL) return root->val;
        deque<TreeNode*> d; int ret;
        d.push_back(root);
        TreeNode* curr;
        while(!d.empty())
        {
            curr = d.front();
            ret=curr->val;
            d.pop_front();
            if(curr->right) d.push_back(curr->right);
            if(curr->left) d.push_back(curr->left);
            
        }
        return ret;

    }
};
// @lc code=end

