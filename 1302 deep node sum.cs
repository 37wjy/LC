/** Given a binary tree, return the sum of values of its deepest leaves.
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public int val;
 *     public TreeNode left;
 *     public TreeNode right;
 *     public TreeNode(int x) { val = x; }
 * }
 */

 /* DFS 深度优先算法*/
 /*
 Runtime: 112 ms, faster than 93.38% of C# online submissions for Deepest Leaves Sum.
Memory Usage: 34.1 MB, less than 100.00% of C# online submissions for Deepest Leaves Sum.
*/
public class Solution {
    int dep=0;
    public int DeepestLeavesSum(TreeNode root) {
        List<int> sum=new List<int>();
        cnt(root,0,ref sum);
        return sum[dep];
    }
    void cnt(TreeNode nd, int depth,ref List<int> arr){
        if(depth>arr.Count-1)arr.Add(nd.val);
        else if(depth==arr.Count-1)arr[depth]+=nd.val;
        dep=dep>=depth?dep:depth;
        if(nd.left!=null)cnt(nd.left,depth+1,ref arr);
        if(nd.right!=null)cnt(nd.right,depth+1,ref arr);
    }
}