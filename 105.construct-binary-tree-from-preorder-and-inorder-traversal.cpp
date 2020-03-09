/*
 * @lc app=leetcode id=105 lang=cpp
 *
 * [105] Construct Binary Tree from Preorder and Inorder Traversal
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
    int it=0; 
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
       return create(preorder, inorder, 0, preorder.size() - 1, 0, inorder.size() - 1);
    }

    TreeNode* create(vector<int>& preorder, vector<int>& inorder, int ps, int pe, int is, int ie){
        if(ps > pe){
            return nullptr;
        }
        TreeNode* node = new TreeNode(preorder[ps]);
        int pos;
        for(int i = is; i <= ie; i++){
            if(inorder[i] == node->val){
                pos = i;
                break;
            }
        }
        node->left = create(preorder, inorder, ps + 1, ps + pos - is, is, pos - 1);
        node->right = create(preorder, inorder, pe - ie + pos + 1, pe, pos + 1, ie);
        return node;
    }
};
// @lc code=end

