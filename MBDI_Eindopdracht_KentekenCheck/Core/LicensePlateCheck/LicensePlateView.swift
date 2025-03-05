import SwiftUI

struct LicensePlateCheckView: View {
    @StateObject private var rdwManager = RDWManager()
    @State private var rawLicensePlate: String = ""
    @State private var navigateToCarView = false
    @State private var selectedVehicle: Vehicle?
    @State private var recentPlates: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                Text("KENTEKENCHECK")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                LicensePlateInputView(licensePlate: $rawLicensePlate)

                Button(action: {
                    let licensePlate = LicensePlate(rawLicensePlate: rawLicensePlate)
                    rdwManager.getVehicle(for: licensePlate)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let vehicle = rdwManager.vehicle {
                            selectedVehicle = vehicle
                            navigateToCarView = true
                        }
                    }
                }) {
                    Text("Check Kenteken")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                if let errorMessage = rdwManager.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                if !recentPlates.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Searches")
                            .font(.headline)
                            .padding(.top)

                        List(recentPlates, id: \.self) { plate in
                            let licensePlate = LicensePlate(rawLicensePlate: plate)

                            Button(action: {
                                rdwManager.getVehicle(for: licensePlate)

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    if let vehicle = rdwManager.vehicle {
                                        selectedVehicle = vehicle
                                        navigateToCarView = true
                                    }
                                }
                            }) {
                                Text(licensePlate.formattedLicensePlate)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        .listStyle(PlainListStyle())
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                loadRecentPlates()
            }
            .navigationDestination(isPresented: $navigateToCarView) {
                if let vehicle = selectedVehicle {
                    CarView(vehicle: vehicle)
                }
            }
        }
    }

    private func loadRecentPlates() {
        recentPlates = rdwManager.loadRecentPlates()
    }
}

#Preview {
    LicensePlateCheckView()
}

