/*
 * @lc app=leetcode id=127 lang=cpp
 *
 * [127] Word Ladder
 */

#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <map>
using namespace std;

// @lc code=start
class Solution {
public:
    int ladderLength(string beginWord, string endWord, vector<string>& wordList) {
        map<int,string> dict(wordList.begin(), wordList.end());
        queue<string> todo;
        todo.push(beginWord);
        int ladder = 1;
        while (!todo.empty()) {
            int n = todo.size();
            for (int i = 1; i <=n; i++) {
                string word = todo.front();
                todo.pop();
                if (word == endWord) {
                    return ladder;
                }
                dict.erase(word);
                for(int i=0;i<dict.size();i++){
                    if (comp(word,dict[i]))
                    {
                        todo.push(dict[i]);
                    }
                }
            }
            ladder++;
        }
        return 0;
    }

    bool comp(string a,string b){
        int j=0;
        for (int i = 0; i < a.size(); i++)
        {
            if(a[i]!=b[i]){j++;
            if (j>1)
                {
                    return false;
                }
            }
        }
        return j;
    }
};
// @lc code=end

