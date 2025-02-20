//
//  TestView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Lars van Herwijnen on 20/02/2025.
//

import SwiftUI

struct RDWTestView: View {
    @StateObject private var rdwManager = RDWManager()
    
    let testKentekens = ["00GXP6", "GLK70Z", "20PRXB", "L914TZ"] // Example kentekens for testing

    var body: some View {
        VStack {
            Text("RDW API Test")
                .font(.title)
                .padding()

            // Button to fetch test vehicles
            Button(action: {
                rdwManager.getVehicles(for: testKentekens)
            }) {
                Label("Fetch Vehicles", systemImage: "car.fill")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Show loading indicator
            if rdwManager.isLoading {
                ProgressView("Loading...")
                    .padding()
            }

            // Show error message
            if let errorMessage = rdwManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Show fetched vehicles
            List(rdwManager.vehicles, id: \.kenteken) { vehicle in
                VStack(alignment: .leading) {
                    Text("Kenteken: \(vehicle.kenteken)")
                        .font(.headline)
                    Text("Merk: \(vehicle.merk)")
                    Text("Model: \(vehicle.handelsbenaming)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    RDWTestView()
}
