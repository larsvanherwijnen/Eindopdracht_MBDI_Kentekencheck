import SwiftUI

struct RideDetailView: View {
    var ride: Ride
    @StateObject private var rdwManager = RDWManager()
    @State private var selectedVehicle: Vehicle?
    @State private var isSheetPresented = false

    var body: some View {
        VStack {
            Text("Voertuigen")
                .font(.title)
                .fontWeight(.bold)

            List {
                ForEach(ride.licensePlates, id: \.self) { plate in
                    let licensePlate = LicensePlate(rawLicensePlate: plate)

                    Button(action: {
                        rdwManager.getVehicle(for: licensePlate) { vehicle in
                            if let vehicle = vehicle {
                                DispatchQueue.main.async {
                                    selectedVehicle = vehicle
                                }
                            }
                        }
                        
                        isSheetPresented = true
                    }) {
                        HStack {
                            Text(LicensePlateFormatter.format(plate))
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                    .sheet(
                        isPresented: $isSheetPresented,
                        onDismiss: {
                            selectedVehicle = nil
                        }
                    ) {
                        if let vehicle = selectedVehicle {
                            CarView(vehicle: vehicle)
                        } else {
                            if let errorMessage = rdwManager.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(ride.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RideDetailView(ride: Ride(name: "Test Ride", licensePlates: ["AA124B"]))
}
