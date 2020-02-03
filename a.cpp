#include <iostream>
#include <vector>

using namespace std;

int main(int argc, char const *argv[])
{
    vector<int> v{1,2};
    vector<vector<int >> vv;
    vv.push_back(v);
    v.push_back(2);
    vv.push_back(v);
    ;

    return 0;
}
