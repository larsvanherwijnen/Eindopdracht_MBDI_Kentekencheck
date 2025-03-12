import Foundation

class RDWManager: ObservableObject {
    @Published var vehicle: Vehicle?
    @Published var vehicles: [Vehicle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let recentPlatesKey = "RecentLicensePlates"
    private let vehicleCachePrefix = "Vehicle_"

    func getVehicle(for licensePlate: LicensePlate, completion: @escaping (Vehicle?) -> Void) {
        let plateNumber = licensePlate.rawLicensePlate.uppercased()
        let urlString = "https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=\(plateNumber)"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Ongeldige URL"
                completion(nil)
            }
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async { self?.isLoading = false }

            guard let self = self, let data = data else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Geen data ontvangen"
                    completion(nil)
                }
                return
            }

            do {
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                DispatchQueue.main.async {
                    if let firstVehicle = vehicles.first {
                        self.vehicle = firstVehicle
                        self.updateRecentPlates(plateNumber)
                        completion(firstVehicle) // ✅ Call completion with vehicle
                    } else {
                        self.errorMessage = "Geen voertuig gevonden"
                        completion(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoderen mislukt: \(error.localizedDescription)"
                    completion(nil)
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
