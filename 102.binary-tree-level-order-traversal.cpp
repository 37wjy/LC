/*
 * @lc app=leetcode id=102 lang=cpp
 *
 * [102] Binary Tree Level Order Traversal
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
    vector<vector<int>> levelOrder(TreeNode* root) {
        vector<vector<int>> v;
        if(!root)
            return v;
        queue <TreeNode * > q;
        q.push(root);
        int i =0;
        while(!q.empty())
        {
            int cnt = q.size();
            vector < int> x;
            while(cnt--)
            {

                TreeNode * f = q.front();
                q.pop();
                
                x.push_back(f->val);
                
                if(f->left!=NULL)
                    q.push(f->left);
                if(f->right!=NULL)
                    q.push(f->right);
                
            }
            v.push_back(x);
        }
        
        return v;
    }
};
// @lc code=end

