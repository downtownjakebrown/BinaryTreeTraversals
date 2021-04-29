
import Foundation

// MARK: - TreeNode
public class TreeNode: CustomStringConvertible {
    
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init() { self.val = 0; self.left = nil; self.right = nil; }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) { self.val = val; self.left = left; self.right = right; }
    public init(_ vals: [Int?]) {
        
        if vals.count == 0 {
            self.val = 0; self.left = nil; self.right = nil;
            return
        }
        
        if vals.count == 1 || vals[0] == nil {
            self.val = vals[0] ?? 0; self.left = nil; self.right = nil;
            return
        }
        
        self.val = vals[0]!
        
        let dummy = insert(vals, 0)
        self.left = dummy?.left
        self.right = dummy?.right
        
    }
    
    private func insert(_ vals: [Int?], _ i: Int) -> TreeNode? {
        if (i < vals.count) {
            if let val = vals[i] {
                let newNode = TreeNode(val)
                newNode.left = insert(vals, 2*i + 1)
                newNode.right = insert(vals, 2*i + 2)
                return newNode
            }
        }
        return nil
    }
    
    public var description: String {
        var text = "["
        var queue = [TreeNode]()
        queue.append(self)
        while !queue.isEmpty {
            for _ in 0..<queue.count {
                let node = queue.removeFirst()
                text += " \(node.val)"
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
        }
        text += " ]"
        return text
    }
    
}

// MARK: - LevelOrder
public class LevelOrder {

    // MARK: Iterative
    @discardableResult public static func solution(_ tree: TreeNode?) -> (Int, [Int]) {
        
        guard let tree = tree else { return (0, []) }
        
        var queue = [TreeNode]()
        queue.append(tree)
        
        var level: Int = 0
        var vals = [Int]()
        
        while !queue.isEmpty {
            
            for _ in 0..<queue.count {
                
                let node = queue.removeFirst()
                vals.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                
                if let right = node.right {
                    queue.append(right)
                }
                
            }
            
            level += 1
        
        }
        
        print("""
        LevelOrder:
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
}

// MARK: - PreOrder
public class PreOrder {
    
    // MARK: Iterative
    @discardableResult public static func solutionIterative(_ tree: TreeNode?) -> (Int, [Int]) {
        
        guard let tree = tree else { return (0, [])}
        
        var stack = [(Int, TreeNode)]()
        stack.append((1, tree))
        
        var level: Int = 0
        var vals = [Int]()
        
        while !stack.isEmpty {
            
            let (lvl, last) = stack.last!
            stack.removeLast()
            
            vals.append(last.val)
            
            if let right = last.right {
                stack.append((lvl + 1, right))
            }
            
            if let left = last.left {
                stack.append((lvl + 1, left))
            }
            
            if lvl > level {
                level = lvl
            }
            
        }
        
        print("""
        PreOrder (Iterative):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level,vals)
        
    }
    
    // MARK: Recursive
    @discardableResult public static func solutionRecursive(_ tree: TreeNode?) -> (Int, [Int]) {
        
        guard let tree = tree else { return (0, [])}
        
        var vals = [Int]()
        let level = search(tree, 1, &vals)
        
        print("""
        PreOrder (Recursive):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
    private static func search(_ tree: TreeNode, _ level: Int, _ vals: inout [Int]) -> Int {
        
        vals.append(tree.val)
        
        var leftLevel = 0
        if let left = tree.left {
            leftLevel = search(left, level + 1, &vals)
        }
        
        var rightLevel = 0
        if let right = tree.right {
            rightLevel = search(right, level + 1, &vals)
        }
        
        return max(level, max(leftLevel, rightLevel))
        
    }
    
}

// MARK: - InOrder
public class InOrder {
    
    // MARK: Iterative
    @discardableResult public static func solutionIterative(_ tree: TreeNode?) -> (Int, [Int]) {
        
        guard let tree = tree else { return (0,[]) }
                
        var vals = [Int]()
        var level: Int = 0
        
        var stack = [(Int, TreeNode)]()
        var currentNode: TreeNode? = tree
        
        while !stack.isEmpty || currentNode != nil {
            
            while (currentNode != nil) {
                let lvl = stack.last?.0 ?? 1
                stack.append((lvl + 1, currentNode!))
                
                if lvl > level {
                    level = lvl
                }
                
                currentNode = currentNode!.left
            }

            currentNode = stack.removeLast().1
            vals.append(currentNode!.val)
            currentNode = currentNode!.right
            
        }
           
        print("""
        InOrder (Iterative):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
    // MARK: Recursive
    @discardableResult public static func solutionRecursive(_ tree: TreeNode?) -> (Int, [Int]) {
        
        guard let tree = tree else { return (0,[]) }
        
        var vals = [Int]()
        let level = search(tree, &vals, 1)
        
        print("""
        InOrder (Recursive):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
    private static func search(_ tree: TreeNode, _ vals: inout [Int], _ level: Int) -> Int {
        
        var depthLeft: Int = 0
        if let left = tree.left {
            depthLeft = search(left, &vals, level + 1)
        }
        
        vals.append(tree.val)
        
        var depthRight: Int = 0
        if let right = tree.right {
            depthRight = search(right, &vals, level + 1)
        }
        
        return max(level, max(depthLeft, depthRight))
        
    }
    
}

// MARK: - PostOrder
public class PostOrder {
    
    // MARK: Iterative
    @discardableResult public static func solutionIterative(_ node: TreeNode?) -> (Int, [Int]) {
        
        guard let node = node else { return (0, []) }
        
        var level: Int = 0
        var vals = [Int]()
        
        var stack = [(Int, TreeNode)]()
        stack.append((1, node))
        
        while !stack.isEmpty {
            
            let (lvl, last) = stack.removeLast()
            vals.insert(last.val, at: 0)
            
            if let left = last.left {
                stack.append((lvl + 1, left))
            }
            
            if let right = last.right {
                stack.append((lvl + 1, right))
            }
            
            if lvl > level {
                level = lvl
            }
            
        }
        
        print("""
        PostOrder (Iterative):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
    // MARK: Recursive
    @discardableResult public static func solutionRecursive(_ node: TreeNode?) -> (Int, [Int]) {
        
        guard let node = node else { return (0,[]) }
        
        var vals = [Int]()
        var level: Int = 0
        
        level = search(node, &vals, 1)
        
        print("""
        PostOrder (Recursive):
        - Max Depth: \(level)
        - Node Vals: \(vals)

        """)
        
        return (level, vals)
        
    }
    
    private static func search(_ node: TreeNode, _ values: inout [Int], _ level: Int) -> Int {
           
        var leftLevel: Int = 0
        if let left = node.left {
            leftLevel = search(left, &values, level + 1)
        }
        
        var rightLevel: Int = 0
        if let right = node.right {
            rightLevel = search(right, &values, level + 1)
        }
        
        values.append(node.val)
        
        return max(level, max(rightLevel, leftLevel))
        
    }
    
}
