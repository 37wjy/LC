 #include<iostream>
 using namespace std;
 
 double myPow(double x, int n) {
        if(!x)return 0;
        bool flag=true;
        if(n<0){
            flag=false;
            //n&=0x7fffffff;
            n=(~n)+1;
        }
        double r=1;
        for(int i=0;i<32&&(n>>i)!=0;i++){
           
            if(n>>i&0x1){
                double p2=flag?x:1.0/x;
                
                for(int j=0;j<i;j++){
                    p2*=p2;
                }
                
                r*=p2;
            }
        }
        return r;
    }

int main(int argc, char const *argv[])
{
    cout<<myPow(2,-2)<<endl;
    return 0;
}
