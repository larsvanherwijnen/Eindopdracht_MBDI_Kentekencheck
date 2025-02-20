import Foundation

struct Ride: Identifiable, Codable {
    var id = UUID()
    let name: String
}
