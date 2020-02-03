/*
 * @lc app=leetcode id=257 lang=cpp
 *
 * [257] Binary Tree Paths
 */
#include <iostream>
#include <vector>

using namespace std;
// @lc code=start
/**
 * Definition for a binary tree node.*/
/*  struct TreeNode {
     int val;
     TreeNode *left;
     TreeNode *right;
     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 }; */
 
class Solution {
public:
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> vec;if (root==nullptr)
        {
            return vec;
        }
        func(root,"",vec);
        return vec;
    }

    void func(TreeNode* root,string s,vector<string>& vec){
        
        
        if (root->left==nullptr&&root->right==nullptr)
        {
            vec.push_back(s+to_string(root->val));
        }
       //s=s+;
        if (root->left!=nullptr)
        {
            func(root->left,s+to_string(root->val)+"->",vec);
        }
        if (root->right!=nullptr)
        {
            func(root->right,s+to_string(root->val)+"->",vec);
        }
    }
};
// @lc code=end

