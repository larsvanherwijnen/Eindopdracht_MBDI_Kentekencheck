import Foundation

struct LicensePlateFormatter {
    
    static func format(_ input: String) -> String {
        let cleanedInput = input.replacingOccurrences(of: "-", with: "").uppercased()

        let patterns: [(pattern: String, format: String)] = [
            ("^[0-9]{2}[A-Z]{2}[A-Z]{2}$", "99-XX-XX"),   // 99-XX-XX
            ("^[0-9]{2}[A-Z]{3}[0-9]$", "99-XXX-9"),      // 99-XXX-9
            ("^[0-9][A-Z]{3}[0-9]{2}$", "9-XXX-99"),      // 9-XXX-99
            ("^[A-Z]{2}[0-9]{3}[A-Z]$", "XX-999-X"),      // XX-999-X
            ("^[A-Z][0-9]{3}[A-Z]{2}$", "X-999-XX"),      // X-999-XX
            ("^[A-Z]{3}[0-9]{2}[A-Z]$", "XXX-99-X")       // XXX-99-X
        ]

        // Try to match cleanedInput with any of the valid patterns
        for (pattern, format) in patterns {
            let regex = try! NSRegularExpression(pattern: pattern)
            if regex.firstMatch(in: cleanedInput, range: NSRange(location: 0, length: cleanedInput.count)) != nil {
                var formattedPlate = format
                
                // Now format the input based on the found match
                var charIndex = 0
                for i in format.indices {
                    let char = format[i]
                    if char == "9" {
                        formattedPlate.replaceSubrange(i...i, with: String(cleanedInput[cleanedInput.index(cleanedInput.startIndex, offsetBy: charIndex)]))
                        charIndex += 1
                    } else if char == "X" {
                        formattedPlate.replaceSubrange(i...i, with: String(cleanedInput[cleanedInput.index(cleanedInput.startIndex, offsetBy: charIndex)]))
                        charIndex += 1
                    }
                }

                return formattedPlate
            }
        }

        // Return the original input if no format matches
        return input
    }
    
    
}
