/*
 * @lc app=leetcode id=107 lang=cpp
 *
 * [107] Binary Tree Level Order Traversal II
 */


#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <stack>
using namespace std;

// @lc code=start

 // Definition for a binary tree node.
 
/*   struct TreeNode {
      int val;
      TreeNode *left;
     TreeNode *right;
      TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 }; */

class Solution {
public:
    vector<vector<int>> levelOrderBottom(TreeNode* root) {
        vector<vector<int>> res;
        if (!root)
        {
            return res;
        }
        stack<queue<TreeNode*>> s;
        queue<TreeNode*> q;
        q.push(root);
        s.push(q);
        while (!q.empty())
        {
            int cnt=q.size();
            while(cnt--)
            {
                TreeNode* tmp=q.front();
                q.pop();
                if (tmp->left!=nullptr)
                {
                    q.push(tmp->left);
                }
                if (tmp->right!=nullptr)
                {
                    q.push(tmp->right);
                }
            }
            s.push(q);
        }
        while (!s.empty())
        {
            vector<int> tmpV;
            q=s.top();
            s.pop();
            int cnt=q.size();
            if(cnt){
            while (cnt--)
            {
                TreeNode* tmp=q.front();
                q.pop();

                tmpV.push_back(tmp->val);
            }
            res.push_back(tmpV);
            }
        }
        
        return res;
        
    }
};
// @lc code=end

