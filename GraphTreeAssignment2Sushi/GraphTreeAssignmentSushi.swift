import Foundation

solution()

func solution() {
    
    // Number of n and m.
    let inputSizes = readLine()!.split(separator: " ").map { Int($0)! }
    let n = inputSizes[0]
    let m = inputSizes[1]
    
    // Nodes for real sushi.
    let inputSushis = readLine()!.split(separator: " ").map { Int($0)! }
    var sushis = [Bool](repeating: false, count: n)
    for i in 0..<inputSushis.count { sushis[inputSushis[i]] = true }
    
    // AdjList and edges.
    var adjList = [[Int]](repeating: [], count: n)
    for _ in 0..<n-1 {
        let edgeInput = readLine()!.split(separator: " ").map { Int($0)! }
        let u = edgeInput[0]
        let v = edgeInput[1]
        
        adjList[u].append(v)
        adjList[v].append(u)
    }
    
    // Distance between two real sushi nodes.
    func distanceOfAllNodes(from: Int, visited: inout [Bool], distance: inout [Int]) {
        visited[from] = true
        
        for v in adjList[from] {
            if !visited[v] {
                distance[v] = distance[from] + 1
                distanceOfAllNodes(from: v, visited: &visited, distance: &distance)
            }
        }
    }
    
//    print(n, m)
//    for i in 0..<n {
//        print(i, sushis[i], adjList[i])
//    }
    
    func furthestRealSushiNode(from: Int) -> Int {
        var furthest = 0
        
        var visited = [Bool](repeating: false, count: n)
        var distance = [Int](repeating: 0, count: n)
        distanceOfAllNodes(from: from, visited: &visited, distance: &distance)
        for i in 0..<adjList.count {
            if sushis[i] && distance[i] > distance[furthest] {
                furthest = i
            }
        }
        
        return furthest
    }
    
    func distanceToNearestSushiNode(from: Int, sushis: inout [Bool]) -> (Int, Int) {
        var nearest = 0
        var lowest = 100_000
        var total = 0
        
        var visited = [Bool](repeating: false, count: n)
        var distance = [Int](repeating: 0, count: n)
        distanceOfAllNodes(from: from, visited: &visited, distance: &distance)
        for i in 0..<adjList.count {
            if sushis[i] && distance[i] < lowest {
                lowest = distance[i]
                nearest = i
                total = distance[nearest]
            }
        }
        
        return (nearest, total)
    }
    
    let start = furthestRealSushiNode(from: 3)
//    let end = furthestRealSushiNode(from: start)
//    print(start, end)
    
    var next: (Int, Int)
    var total = 0
    
//    print(start, sushis)
    sushis[start] = false
    
    next = (start, 0)
    while sushis.reduce(false, { $0 || $1 }) {
        next = distanceToNearestSushiNode(from: next.0, sushis: &sushis)
        sushis[next.0] = false
        total += next.1
//        print(next, sushis)
    }
    
    print(total)
}
