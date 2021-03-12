#include <iostream>
#include <stack>

using  namespace std;

class Solution
{
private:
public:
    string removeDuplicates(string S) {
        string ret="";
        for (auto c : S )
        {
            if (ret.back() == c )
            {
                ret+=c; 
            }
            else
            {
                 ret.pop_back();
            }
        }
        return ret;
    }

    //原字符串去重
    string removeDuplicates2(string S) {
        int top = 0;
        for (char ch : S) {
            if (top == 0 || S[top - 1] != ch) {
                S[top++] = ch;
            } else {
                top--;
            }
        }
        S.resize(top);
        return S;
    }
    
};
    int main(int argc, char const *argv[])
    {
        Solution s;
        cout<<s.removeDuplicates("abbaca");
        return 0;
    }

