import Foundation

class LicensePlate: ObservableObject {
    @Published var rawLicensePlate: String = "" {
        didSet {
            formatLicensePlate()
        }
    }
    
    @Published var formattedLicensePlate: String = "" // ✅ Still needed for display

    init(rawLicensePlate: String = "") {
        self.rawLicensePlate = rawLicensePlate
        self.formattedLicensePlate = LicensePlateFormatter.format(rawLicensePlate)
    }

    func formatLicensePlate() {
        let formatted = LicensePlateFormatter.format(rawLicensePlate)
        if formatted != formattedLicensePlate {
            DispatchQueue.main.async {
                self.formattedLicensePlate = formatted
                self.objectWillChange.send() // ✅ Ensure UI updates
            }
        }
    }
}
