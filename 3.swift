var houses = ["00": 0]

var x = 0
var y = 0

while let line = readLine() {
    for c in line.characters {
        
        print(c, terminator: "")
        
        if c == "^" { y += 1 }
        if c == "v" { y -= 1 }
        if c == "<" { x += 1 }
        if c == ">" { x -= 1 }
        
        let house = "\(x),\(y)"
        
        houses[house] = 0
    }
    print("Santa gave at least one present to \(houses.count) houses")
    houses = ["00": 0]
    x = 0
    y = 0
}
