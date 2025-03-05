//
//  RideListView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 25/02/2025.
//

import SwiftUI

struct RideListView: View {
    @EnvironmentObject var rideStore: RideStore

    var body: some View {
        List {
            ForEach(rideStore.rides) { ride in
                VStack(alignment: .leading) {
                    Text(ride.name)
                        .font(.headline)
                }
            }
            .onDelete(perform: deleteRide)
        }
    }

    private func deleteRide(at offsets: IndexSet) {
        rideStore.deleteRide(at: offsets)
    }
}

#Preview {
    RideListView()
}
