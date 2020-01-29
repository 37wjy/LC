#include <iostream>
#include <vector>
using namespace std;

struct TreeNode {
      int val;
      TreeNode *left;
      TreeNode *right;
      TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 };

class Solution {
public:
    
    vector<int> preorderTraversal(TreeNode* root) {
        vector<int> vec;
        go(root,vec);
        return vec;
    }
    
    void go(TreeNode* root,vector<int>& vec){
        if(root==NULL)return;
        vec.push_back(root->val);
        go(root->left,vec);
        go(root->right,vec);
        return;
    }
    
    
};