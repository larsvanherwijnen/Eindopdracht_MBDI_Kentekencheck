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
                        // Fetch the vehicle data
                        rdwManager.getVehicle(for: licensePlate)

                        // Delay the sheet presentation to ensure the vehicle is fetched
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if let vehicle = rdwManager.vehicle {
                                selectedVehicle = vehicle
                                isSheetPresented = true
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
                    // Use sheet to show the CarView
                    .sheet(isPresented: $isSheetPresented, onDismiss: {
                        // Reset selectedVehicle when the sheet is dismissed
                        selectedVehicle = nil
                    }) {
                        if let vehicle = selectedVehicle {
                            CarView(vehicle: vehicle)
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
    RideDetailView(ride: Ride(name: "Test Ride", licensePlates: ["XX-123-X"]))
}
