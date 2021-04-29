
import Foundation

//       1
//      / \
//     2   3
//    /\   /\
//   4  5 6  7
//  /      \
// 8        9

let root = TreeNode([1,2,3,4,5,6,7,8,nil,nil,nil,nil,9])

LevelOrder.solution(root)
PreOrder.solutionRecursive(root)
PreOrder.solutionIterative(root)
PostOrder.solutionRecursive(root)
PostOrder.solutionIterative(root)
InOrder.solutionRecursive(root)
InOrder.solutionIterative(root)
