import Foundation

class LicensePlate: ObservableObject {
    @Published var rawLicensePlate: String = "" {
        didSet {
            formatLicensePlate() // ✅ Call the formatting function when rawLicensePlate changes
        }
    }
    
    @Published var formattedLicensePlate: String = ""

    init(rawLicensePlate: String = "") {
        self.rawLicensePlate = rawLicensePlate
        self.formattedLicensePlate = LicensePlateFormatter.format(rawLicensePlate)
    }

    func formatLicensePlate() {
        formattedLicensePlate = LicensePlateFormatter.format(rawLicensePlate)
    }
}
