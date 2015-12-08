while let parens = readLine() {

    var floor = 0

    for c in parens.characters {
        floor += c == "(" ? 1 : -1
    }

    print("Santa is on floor: \(floor)")
}
