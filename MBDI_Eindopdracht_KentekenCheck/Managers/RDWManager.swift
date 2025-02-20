import Foundation

class RDWManager: ObservableObject {
    @Published var voertuig: Voertuig?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchData(for kenteken: String) {
        guard kenteken.count == 6 else { return }  // Ensure 6 characters

        let urlString =
            "https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=\(kenteken.uppercased())"

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
                let voertuigen = try decoder.decode([Voertuig].self, from: data)
                
                DispatchQueue.main.async {
                    if voertuigen.isEmpty {
                        self.errorMessage = "Geen data ontvangen"
                    } else {
                        self.voertuig = voertuigen.first
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
