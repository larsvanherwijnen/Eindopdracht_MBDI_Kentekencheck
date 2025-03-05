import Foundation
import Combine

struct Ride: Identifiable, Codable {
    var id = UUID()
    let name: String
    let licensePlates: [String]
}
