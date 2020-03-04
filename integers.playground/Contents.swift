import Foundation

let binary = 0b101010
print(binary)

let octal = 0o52
print(octal)

let hex = 0x2A
print(hex)

func reverse(uint: UInt8) -> UInt8? {
    var uintString = String(uint, radix: 2)
    let padding = Array<String>(repeating: "0", count: 8 - uintString.count)
    uintString += padding.joined()
    let reversed = uintString.reversed()
    return UInt8(String(reversed), radix: 2)
}
