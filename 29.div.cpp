#include <iostream>

using namespace std;

int divide(int32_t x, int32_t y) {

    
        if (x == INT32_MIN && y == -1){return INT32_MAX;} // clip to INT_MAX to match test case

        unsigned int dividend = static_cast<unsigned int>(x) * (x<0?-1:1);
        unsigned int divisor = static_cast<unsigned int>(y) * (y<0?-1:1);
        const bool neg = (x < 0) ^ (y < 0);

        int msb{31};
        while(msb>=0){
            if ( (1<<msb) & divisor){ break; }
            --msb;
        }       // get most significant bit of the divisor


        int quotient{0};
        for (int i = (31 - msb); i >= 0; i--)
        {       // start with divisor shifted into largest column possible
            if ((divisor << i) <= dividend)
            {   
                dividend -= divisor << i;
                quotient |= 1 << i;
            }   // subtract multiple of divisor from dividend, add number of multiple to quotient
        }
        if (quotient==INT32_MIN){ return INT32_MIN;} // tricky overflow, int +2147483648 becomes -2147483648
        return (neg)? (~quotient+1) : quotient;
    
}

int main(int argc, char const *argv[])
{
    cout<<divide(-28,1);
    return 0;
}


