import Foundation

var area = 0

while let line = readLine() {
    
    let n = line.characters.split{$0 == "x"}.map(String.init)

    guard let l = Int(n[0]), w = Int(n[1]), h = Int(n[2]) else { fatalError("Bad input") }

    area += 2 * ((l * w) + (w * h) + (h * l))
    area += min(l * w, w * h, h * l) 
}

print("You need \(area) square feet of paper")
