
public class Solution {

    public String removeDuplicates(String S) {
        int now = S.length();
        int next = 1;
        while (now != next) {
            now = S.length();
            S = S.replace("aa", "").replace("bb", "").replace("cc", "").replace("dd", "").replace("ee", "")
                    .replace("ff", "").replace("gg", "").replace("hh", "").replace("ii", "").replace("jj", "")
                    .replace("kk", "").replace("ll", "").replace("mm", "").replace("nn", "").replace("oo", "")
                    .replace("pp", "").replace("qq", "").replace("rr", "").replace("ss", "").replace("tt", "")
                    .replace("uu", "").replace("vv", "").replace("ww", "").replace("xx", "").replace("yy", "")
                    .replace("zz", "");
            next = S.length();
        }
        return S;
    }

    public static void main(String[] args) {

    }
}
