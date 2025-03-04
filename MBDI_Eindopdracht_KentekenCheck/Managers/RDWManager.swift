import Foundation

class RDWManager: ObservableObject {
    @Published var vehicle: Vehicle?
    @Published var vehicles: [Vehicle] = []  // Initialized with an empty array

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func getVehicle(for licensePlate: LicensePlate) {
        print("Manager" + licensePlate.rawLicensePlate)
        
        let urlString = "https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=\(licensePlate.rawLicensePlate)"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Ongeldige URL"
            }
            return
        }

        isLoading = true
        errorMessage = nil

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Geen data ontvangen"
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let vehicles = try decoder.decode([Vehicle].self, from: data)
                
                DispatchQueue.main.async {
                    if vehicles.isEmpty {
                        self.errorMessage = "Geen data ontvangen"
                    } else {
                        self.vehicle = vehicles.first
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoderen mislukt: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }
    
    func getVehicles(for kentekens: [String]) {
        let filteredKentekens = kentekens.filter { $0.count == 6 }
        guard !filteredKentekens.isEmpty else { return }
        
        // Format kentekens for the query
        let kentekenQuery = filteredKentekens.joined(separator: "','")
        
        let urlString = "https://opendata.rdw.nl/resource/m9d7-ebf2.json?$where=kenteken in('" + kentekenQuery + "')"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.errorMessage = "Ongeldige URL"
            }
            return
        }

        isLoading = true
        errorMessage = nil

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "Geen data ontvangen"
                }
                return
            }

            let decoder = JSONDecoder()

            do {
                let vehicles = try decoder.decode([Vehicle].self, from: data)
                
                DispatchQueue.main.async {
                    if vehicles.isEmpty {
                        self.errorMessage = "Geen voertuigen gevonden"
                    } else {
                        self.vehicles = vehicles  // Store all vehicles instead of just the first one
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoderen mislukt: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }

}
