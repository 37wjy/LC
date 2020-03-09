/*
 * @lc app=leetcode id=417 lang=java
 *
 * [417] Pacific Atlantic Water Flow
 */

// @lc code=start
class Solution {
    public List<List<Integer>> pacificAtlantic(int[][] matrix) {

        List<List<Integer>> ans = new LinkedList<>();
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return ans;
        }
        int rows = matrix.length;
        int cols = matrix[0].length;
        boolean[][] pVisited = new boolean[rows][cols];
        boolean[][] aVisited = new boolean[rows][cols];
        Queue<int[]> pQueue = new LinkedList<>();
        Queue<int[]> aQueue = new LinkedList<>();
        for (int i = 0; i < rows; i++) { // Vertical
            pQueue.offer(new int[] { i, 0 });
            aQueue.offer(new int[] { i, cols - 1 });
            pVisited[i][0] = true;
            aVisited[i][cols - 1] = true;
        }
        for (int i = 0; i < cols; i++) { // Horizontal
            pQueue.offer(new int[] { 0, i });
            aQueue.offer(new int[] { rows - 1, i });
            pVisited[0][i] = true;
            aVisited[rows - 1][i] = true;
        }
        bfs(matrix, pQueue, pVisited);
        bfs(matrix, aQueue, aVisited);
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (pVisited[i][j] && aVisited[i][j]) {
                    ans.add(Arrays.asList(i, j));
                }
            }
        }
        return ans;
    }

    public void bfs(int[][] matrix, Queue<int[]> queue, boolean[][] visited) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] dx = new int[] { 0, 1, -1, 0 };
        int[] dy = new int[] { 1, 0, 0, -1 };
        while (!queue.isEmpty()) {
            int[] node = queue.poll();
            for (int i = 0; i < 4; i++) {
                int x = node[0] + dx[i];
                int y = node[1] + dy[i];
                if (x < 0 || x >= rows || y < 0 || y >= cols || visited[x][y]
                        || matrix[x][y] < matrix[node[0]][node[1]]) {
                    continue;
                }
                visited[x][y] = true;
                queue.offer(new int[] { x, y });
            }
        }

    }
}
// @lc code=end
