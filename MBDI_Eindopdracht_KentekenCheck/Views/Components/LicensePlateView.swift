import SwiftUI

struct LicensePlateView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var rdwManager = RDWManager()
    @State private var kenteken: String = ""

    var body: some View {
        VStack {
            ZStack {
                Image("Kentekenplaat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)

                TextField(
                    "",
                    text: $kenteken,
                    prompt: Text("Voer kenteken in")
                        .font(.system(size: 24))
                        .fontWeight(.regular)
                        .foregroundStyle(Color.licensePlateInput)
                )
                .multilineTextAlignment(.center)
                .font(Font.custom("Kenteken", size: 30))
                .foregroundStyle(Color.black)
                .tint(Color.black)
                .frame(width: 200, height: 50)
                .textInputAutocapitalization(.characters)
                .onSubmit {
                    if kenteken.count == 6 {
                        rdwManager.getVehicle(for: kenteken)
                    }
                }
            }
            .padding()

            if let errorMessage = rdwManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if let vehicle = rdwManager.vehicle {
                VStack {
                    Text("Merk: \(vehicle.merk)")
                    Text("Model: \(vehicle.handelsbenaming)")
                    Text("APK Vervaldatum: \(vehicle.vervaldatum_apk)")
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    LicensePlateView()
}
