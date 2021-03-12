import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int minCut(String s) {
        int res=0;
        List<List<Boolean> > li= new ArrayList<>(s.length());
        for (int i = 0; i < s.length(); i++) {
            li.add(new ArrayList<Boolean>(i,true));
            
        }
        return res;
    }
}
