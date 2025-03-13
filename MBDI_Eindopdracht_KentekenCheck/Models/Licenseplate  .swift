import Foundation

class LicensePlate: ObservableObject {
    @Published var rawLicensePlate: String = "" {
        didSet {
            formatLicensePlate() 
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
