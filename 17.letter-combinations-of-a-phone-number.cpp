/*
 * @lc app=leetcode id=17 lang=cpp
 *
 * [17] Letter Combinations of a Phone Number
 */
#include <iostream>
#include <vector>
using namespace std;
// @lc code=start
class Solution {
public:
    vector<string> letterCombinations(string digits) {
        vector<string> res{""};
        static const vector<string> v = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        vector<string> tmp;
        for (int i = 0; i < digits.size(); i++)
        {
            int num=digits[i]-'0';
            if(num>9||num<0)break;
            if(v[num]=="")continue;
            tmp.clear();
            for(string a:res){
                for(char b:v[num]){
                    tmp.push_back(a+b);
                }
            }
            swap(tmp,res);
        }
        if(res[0]=="")res.clear();
        return res;
        
    }
};
// @lc code=end

