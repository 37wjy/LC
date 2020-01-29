#include<iostream>
#include <unordered_map>

using namespace std;

int main(int argc, char const *argv[])
{
    unordered_map<string,int> mp;
    int result = -1;
    string strs[]={"dewdw","casc","dsad"};
    for(auto& str : strs)
    {
        mp[str]++;
    }
    for (auto && i : mp)
    {
        cout<<i.second<<endl;
        cout<<i.first;
    }
    
    return 0;
}
