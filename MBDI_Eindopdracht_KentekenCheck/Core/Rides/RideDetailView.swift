//
//  RideDetailView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 25/02/2025.
//

import SwiftUI

struct RideDetailView: View {
    var ride: Ride
    
    var body: some View {
        VStack {
            List {
                ForEach(ride.licensePlates, id: \.self) { plate in
                    HStack(alignment: .center) {
                        Text(plate)
                            .font(.headline)
                    }
                }
            }
        }
        .navigationTitle(ride.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RideDetailView(ride: Ride(name: "test", licensePlates: []))
}
