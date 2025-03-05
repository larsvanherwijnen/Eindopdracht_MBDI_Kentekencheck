import Foundation

class RDWManager: ObservableObject {
    @Published var vehicle: Vehicle?
    @Published var vehicles: [Vehicle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let recentPlatesKey = "RecentLicensePlates"
    private let vehicleCachePrefix = "Vehicle_"

    func getVehicle(for licensePlate: LicensePlate) {
        let plateNumber = licensePlate.rawLicensePlate.uppercased()

        let urlString = "https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=\(plateNumber)"

        guard let url = URL(string: urlString) else {
            self.errorMessage = "Ongeldige URL"
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { self.isLoading = false }

            guard let data = data else {
                DispatchQueue.main.async { self.errorMessage = "Geen data ontvangen" }
                return
            }

            do {
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                DispatchQueue.main.async {
                    if vehicles.isEmpty {
                        self.errorMessage = "Geen voertuig gevonden"
                    } else {
                        self.vehicle = vehicles.first
                        self.updateRecentPlates(plateNumber)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoderen mislukt: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func updateRecentPlates(_ plate: String) {
        var recentPlates = loadRecentPlates()

        if !recentPlates.contains(plate) {
            recentPlates.insert(plate, at: 0)
        }

        if recentPlates.count > 5 {
            let oldestPlate = recentPlates.removeLast()
            let key = "\(vehicleCachePrefix)\(oldestPlate)"
            UserDefaults.standard.removeObject(forKey: key)
        }

        UserDefaults.standard.set(recentPlates, forKey: recentPlatesKey)
    }

    func loadRecentPlates() -> [String] {
        return UserDefaults.standard.array(forKey: recentPlatesKey) as? [String] ?? []
    }
    
}
