import SwiftUI

struct RideDetailView: View {
    var ride: Ride
    @StateObject private var rdwManager = RDWManager()
    @State private var selectedVehicle: Vehicle?
    @State private var selectedLicensePlate: String?
    @State private var isEditing = false

    var body: some View {
        ZStack {
            VStack {
                Text(ride.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                List {
                    Section {
                        ForEach(ride.licensePlates, id: \.self) { plate in
                            let licensePlate = LicensePlate(rawLicensePlate: plate)

                            Button(action: {
                                rdwManager.getVehicle(for: licensePlate) { vehicle in
                                    DispatchQueue.main.async {
                                        selectedVehicle = vehicle
                                        selectedLicensePlate = plate
                                    }
                                }
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
                                isPresented: .constant(selectedLicensePlate == plate),
                                onDismiss: { selectedLicensePlate = nil }
                            ) {
                                if let vehicle = selectedVehicle {
                                    CarView(vehicle: vehicle)
                                } else if let errorMessage = rdwManager.errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                        }
                    } header: {
                        Text("Voertuigen")
                    }
                }
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isEditing = true
                    }) {
                        Image(systemName: "pencil")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            RideFormView(ride: ride)
        }
    }
}

#Preview {
    RideDetailView(
        ride: Ride(name: "Test Ride", licensePlates: ["XX123X", "GLK70Z"])
    )
}
