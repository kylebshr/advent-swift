import Foundation

var row = [Bool](count: 1000, repeatedValue: false)
var lights = [[Bool]](count: 1000, repeatedValue: row)

while let line = readLine() {
    
    let instructions = line.characters.split{$0 == " "}.map(String.init)
    
    let first = instructions[0] == "toggle" ? 1 : 2
    let second = instructions[0] == "toggle" ? 3 : 4
    
    let firstPoint = instructions[first].characters.split{$0 == ","}.map(String.init)
    let xFirst = Int(firstPoint[0])!
    let yFirst = Int(firstPoint[1])!
    let secondPoint = instructions[second].characters.split{$0 == ","}.map(String.init)
    let xSecond = Int(secondPoint[0])!
    let ySecond = Int(secondPoint[1])!

    for i in xFirst...xSecond {
        for j in yFirst...ySecond {
            lights[i][j] = instructions[0] == "toggle" ? !lights[i][j] : instructions[1] == "on"
        }
    }
}

// sorry for illegibilty, was having fun with reduce
let lit = lights.reduce(0) { $0 + $1.reduce(0) { return $0 + ($1 ? 1 : 0) } }

print("There are \(lit) lit")
