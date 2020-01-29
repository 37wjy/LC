/*
 * @lc app=leetcode id=103 lang=cpp
 *
 * [103] Binary Tree Zigzag Level Order Traversal
 */

#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
using namespace std;

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
    vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
        vector<vector<int>> v;
        if(!root)
            return v;
        queue <TreeNode * > q;
        q.push(root);
        int i =0,j=1;
        while(!q.empty())
        {
            int cnt = q.size();
            vector<int> x;
            while(cnt--)
            {

                TreeNode * f = q.front();
                q.pop();
                
                x.push_back(f->val);
                
                if(f->right!=NULL)
                    q.push(f->right);
                if(f->left!=NULL)
                    q.push(f->left);
            }
            if (j&0x01)
            {
                std::reverse(x.begin(),x.end());
            }
            v.push_back(x);
            j++;
        }
        
        return v;
    }
};
// @lc code=end

