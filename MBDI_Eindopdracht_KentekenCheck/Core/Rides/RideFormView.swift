import SwiftUI

struct RideFormView: View {
    @EnvironmentObject var rideStore: RideStore
    @Environment(\.dismiss) private var dismiss

    var ride: Ride?  // Optional ride for editing

    @State private var rideName: String
    @State private var licensePlates: [String]
    @State private var showError = false
    @State private var invalidPlates: [Int] = []

    init(ride: Ride? = nil) {
        _rideName = State(initialValue: ride?.name ?? "")
        _licensePlates = State(initialValue: ride?.licensePlates ?? [""])
        self.ride = ride
    }

    var body: some View {
        Form {
            Section(header: Text("Rit gegevens")) {
                TextField("Rit naam", text: $rideName)
                    .onChange(of: rideName) {
                        showError = rideName.isEmpty
                    }

                if showError {
                    Text("De rit naam is verplicht.")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }

            Section(header: Text("Kentekenplaten (optioneel)")) {
                ForEach(licensePlates.indices, id: \.self) { index in
                    HStack {
                        TextField(
                            "Kentekenplaat \(index + 1)",
                            text: $licensePlates[index]
                        )
                        .autocapitalization(.allCharacters)
                        .onChange(of: licensePlates[index]) {
                            validateLicensePlates()
                        }

                        if licensePlates.count > 1 {
                            Button(action: {
                                licensePlates.remove(at: index)
                                validateLicensePlates()
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }

                    if invalidPlates.contains(index) {
                        Text(
                            "Ongeldig kenteken. Formaat: 99XXXX, 99XXX9, 9XXX99, XX999X, X999XX, XXX99X"
                        )
                        .foregroundColor(.red)
                        .font(.caption)
                    }
                }

                Button(action: {
                    licensePlates.append("")
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Kentekenplaat toevoegen")
                    }
                    .foregroundColor(.blue)
                }
            }

            Section {
                Button(action: saveRide) {
                    Text(ride != nil ? "Wijzigen" : "Opslaan")
                        .frame(maxWidth: .infinity)
                }
                .disabled(rideName.isEmpty || !invalidPlates.isEmpty)
            }
        }
    }
    
    private func saveRide() {
        guard !rideName.isEmpty, invalidPlates.isEmpty else { return }
        
        let nonEmptyPlates = licensePlates.filter { !$0.isEmpty }

        if let ride = ride {
            rideStore.updateRide(
                id: ride.id,
                name: rideName,
                licensePlates: licensePlates
            )
        } else {
            rideStore.addRide(name: rideName, licensePlates: nonEmptyPlates)
        }
        
        dismiss()
    }

    private func validateLicensePlates() {
        invalidPlates.removeAll()

        for (index, plate) in licensePlates.enumerated() {
            let cleanedPlate = plate.replacingOccurrences(of: "-", with: "")
                .uppercased()

            let validPatterns = [
                "^[0-9]{2}[A-Z]{2}[A-Z]{2}$",  // 99XXXX
                "^[0-9]{2}[A-Z]{3}[0-9]$",  // 99XXX9
                "^[0-9][A-Z]{3}[0-9]{2}$",  // 9XXX99
                "^[A-Z]{2}[0-9]{3}[A-Z]$",  // XX999X
                "^[A-Z][0-9]{3}[A-Z]{2}$",  // X999XX
                "^[A-Z]{3}[0-9]{2}[A-Z]$",  // XXX99X
            ]

            let isValid = validPatterns.contains { pattern in
                let regex = try! NSRegularExpression(pattern: pattern)
                return regex.firstMatch(
                    in: cleanedPlate,
                    range: NSRange(location: 0, length: cleanedPlate.count))
                    != nil
            }

            if !isValid && !cleanedPlate.isEmpty {
                invalidPlates.append(index)
            }
        }
    }
}

