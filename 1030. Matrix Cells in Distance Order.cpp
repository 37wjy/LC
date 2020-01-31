
/* 
We are given a matrix with R rows and C columns has cells with integer coordinates (r, c), where 0 <= r < R and 0 <= c < C.

Additionally, we are given a cell in that matrix with coordinates (r0, c0).

Return the coordinates of all cells in the matrix, sorted by their distance from (r0, c0) from smallest distance to largest distance.  Here, the distance between two cells (r1, c1) and (r2, c2) is the Manhattan distance, |r1 - r2| + |c1 - c2|.  (You may return the answer in any order that satisfies this condition.)

 

Example 1:

Input: R = 1, C = 2, r0 = 0, c0 = 0
Output: [[0,0],[0,1]]
Explanation: The distances from (r0, c0) to other cells are: [0,1]
Example 2:

Input: R = 2, C = 2, r0 = 0, c0 = 1
Output: [[0,1],[0,0],[1,1],[1,0]]
Explanation: The distances from (r0, c0) to other cells are: [0,1,1,2]
The answer [[0,1],[1,1],[0,0],[1,0]] would also be accepted as correct.
Example 3:

Input: R = 2, C = 3, r0 = 1, c0 = 2
Output: [[1,2],[0,2],[1,1],[0,1],[1,0],[0,0]]
Explanation: The distances from (r0, c0) to other cells are: [0,1,1,2,2,3]
There are other answers that would also be accepted as correct, such as [[1,2],[1,1],[0,2],[1,0],[0,1],[0,0]].

*/




class Solution {
public:
    vector<vector<int>> allCellsDistOrder(int R, int C, int r0, int c0) {
        vector<vector<int>> v;
        v.push_back(vector<int>{ r0,c0 });
        int mxdis=max(max(R-r0+C-c0,r0+c0),max(r0+C-c0,c0+R-r0));
        
        for(int i=1;i<=mxdis;i++){
           /* int lt=i*4-(i+r0)>=R?(i+r0+1-R)*2-1:0-(i+c0)>=C?(i+c0+1-C)*2-1:0-(c0-i)>=0?0:(i-c0)*2-1-(r0-i)>=0?0:(i-r0)*2-1;
            int x=r0-i;
            int y=c0;
            for(;lt>0;lt--){
                 if()*/
            int x=r0-i;
            int y=c0;
            for(int j=i*4;j>0;j--){
                if(x>=0&&y>=0&&x<R&&y<C)v.push_back(vector<int>{x,y});
                if(j>3*i){x++;y--;}
                else if(j>2*i){x++;y++;}
                else if(j>i){x--;y++;}
                else {x--;y--;}
            }
        }
        return v;
    } 
};   
      
       