import Foundation

extension String {
    
    var nice: Bool {
        
        for string in ["ab", "cd", "pq", "xy"] {
            if rangeOfString(string) != nil {
                return false
            }
        }
        
        var last: Character = " "
        var vowels = 0
        var double = false
        
        for c in characters {
            
            if c == last {
                double = true
            }
            
            last = c
            
            switch c {
            case "a","e","i","o","u": vowels += 1
            default: continue
            }
        }
        
        return vowels >= 3 && double
    }
}

var nice = 0

while let line = readLine() {
    if line.nice {
        nice += 1
    }
}

print("There are \(nice) nice strings!")
