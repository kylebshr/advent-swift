protocol SignalGenerator {
    var value: UInt16? { get }
}

struct RawSignal: SignalGenerator {
    
    var rawValue: UInt16?
    var signal: WireWrapper?
    
    var value: UInt16? {
        return rawValue ?? signal?.value
    }
}

struct NotGate: SignalGenerator {
    
    var rawValue: UInt16?
    var signal: WireWrapper?
    
    var value: UInt16? {
        
        if let value = rawValue ?? signal?.value {
            return ~value
        }
        
        return nil
    }
}

struct DoubleInputGate: SignalGenerator {
    
    var firstRawValue: UInt16?
    var secondRawValue: UInt16?
    var firstSignal: WireWrapper?
    var secondSignal: WireWrapper?
    var gate: String
    
    var value: UInt16? {
        
        if let first = firstRawValue ?? firstSignal?.value,
            second = secondRawValue ?? secondSignal?.value
        {
            switch gate {
            case "AND":     return first & second
            case "OR":      return first | second
            case "LSHIFT":  return first << second
            case "RSHIFT":  return first >> second
            default: ()
            }
        }
        
        return nil
    }
}

class WireWrapper {
    
    let id: String
    
    var signal: SignalGenerator?
    
    var value: UInt16? {
        
        print("Getting value for id: \(id)")
        
        return signal?.value
    }
    
    init(id: String) {
        self.id = id
    }
}

class Circuit {
    
    private var wires = [WireWrapper]()
    
    func valueForID(id: String) -> UInt16? {
        return wires.filter({ $0.id == id}).first?.value
    }
    
    private func wire(id: String) -> WireWrapper? {
        
        if let wire = wires.filter({ $0.id == id}).first {
            return wire
        }
        let wire = WireWrapper(id: id)
        wires.append(wire)
        return wire
    }
    
    func setInstruction(instruction: String) {
        
        print("Adding instruction: \(instruction)")
        
        let instr = instruction.characters.split { $0 == " " }.map(String.init)

        // The last instruction is always the ID
        guard let currentWire = wire(instr.last!) else { return }
        
        if instr.count == 3 {
            currentWire.signal = RawSignal(rawValue: UInt16(instr[0]), signal: wire(instr[0]))
        }
        else if instr.count == 4 {
            currentWire.signal = NotGate(rawValue: UInt16(instr[1]), signal: wire(instr[1]))
        }
        else if instr.count == 5 {
            currentWire.signal = DoubleInputGate(
                firstRawValue: UInt16(instr[0]),
                secondRawValue: UInt16(instr[2]),
            	firstSignal: wire(instr[0]),
                secondSignal: wire(instr[2]),
                gate: instr[1]
            )
        }
    }
}

let circuit = Circuit()

while let line = readLine() {
    circuit.setInstruction(line)
}

print("Wire a has value: \(circuit.valueForID("a"))")
