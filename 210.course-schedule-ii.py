#
# @lc app=leetcode id=210 lang=python3
#
# [210] Course Schedule II
#
import os
from typing import List
import collections

set=[[0,2],[2,4],[4,5]]

# @lc code=start
class Solution:
    def findOrder( numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        dic = {i: prerequisites for i in range(numCourses)}
        neigh = collections.defaultdict(prerequisites)
        for i, j in prerequisites:
            dic[i].add(j)
            neigh[j].add(i)
        # queue stores the courses which have no prerequisites
        queue = collections.deque([i for i in dic if not dic[i]])
        count, res = 0, []
        while queue:
            node = queue.popleft()
            res.append(node)
            count += 1
            for i in neigh[node]:
                dic[i].remove(node)
                if not dic[i]:
                    queue.append(i)
        return res if count == numCourses else []
# @lc code=end

Solution.findOrder(3,set)