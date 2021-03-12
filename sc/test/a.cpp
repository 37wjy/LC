#include <iostream>
#include <vector>

using namespace std;

class a
{
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int X) {
        int ret=0;
        int t=0;
        for(int i = 0;i<customers.size();i++) {
            ret += customers[i] * !grumpy[i];
            t = max(t + (customers[i] * grumpy[i]) - ( (i >= X )? (customers[i-X] * grumpy[i-X]) : 0 ), t);
        }
        return ret+t;
    }

    int main(int argc, char const *argv[])
    {
        auto a=new std::vector<int>({1,0,1,2,1,1,7,5});
        auto b=new std::vector<int>({0,1,0,1,0,1,0,1});
        cout<<maxSatisfied(*a,*b,3);
        return 0;
    }
    
};
