/*
 * @lc app=leetcode id=99 lang=cpp
 *
 * [99] Recover Binary Search Tree
 */

// @lc code=start
/* #include <iostream>
#include <vector>
using namespace std;
#define INT_MIN -999999
 //Definition for a binary tree node.
 struct TreeNode {
     int val;
     TreeNode *left;
     TreeNode *right;
     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 }; */

class Solution {
public:

    TreeNode* pre;
    TreeNode* tmp;
    void recoverTree(TreeNode* root) {
        pre=new TreeNode(INT_MIN);
        travel(root);
    }

    void travel(TreeNode* root){
        if (root==nullptr)      
        {
            return;
        }
        travel(root->left);
        if(pre->val >root->val){
            if (tmp!=NULL)
            {
                swapNd(root,tmp);
                return;
            }
            tmp=pre;
        }
        pre=root;
        travel(root->right);
    }

    void swapNd(TreeNode* nd1,TreeNode* nd2){
        int v=nd1->val;
        nd1->val=nd2->val;
        nd2->val=v;
    }
};
// @lc code=end

