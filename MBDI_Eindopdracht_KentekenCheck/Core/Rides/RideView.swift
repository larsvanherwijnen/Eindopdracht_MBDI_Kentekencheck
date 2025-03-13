//
//  RideView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 20/02/2025.
//

import SwiftUI

struct RideView: View {
    @EnvironmentObject var rideStore: RideStore

    @State private var isShowingPopup = false
    @State private var isEditing = false
    @State private var newRideName = ""
    @State private var licensePlates: [String] = []
    
    @Environment(\.editMode) private var editMode

    var body: some View {
        NavigationStack {
            VStack {
                Text("Rit overzicht")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                List {
                    ForEach(rideStore.rides) { ride in
                        HStack(alignment: .center) {
    
                            NavigationLink(ride.name, destination: RideDetailView(ride: ride))
                                .buttonStyle(.borderedProminent)
                        }
                    }
                    .onDelete(perform: deleteRide)
                }
            
                .environment(\.editMode, .constant(isEditing ? .active : .inactive))

                Button(action: {
                    isShowingPopup = true
                }) {
                    Text("Maak rit aan")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $isShowingPopup) {
                RideFormView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing.toggle()
                        editMode?.animation().wrappedValue =
                            isEditing ? .active : .inactive
                    }) {
                        Text(isEditing ? "Klaar" : "Bewerken")
                    }
                }
            }
        }
    }

    private func deleteRide(at offsets: IndexSet) {
        rideStore.deleteRide(at: offsets)
    }
}

#Preview {
    RideView()
        .environmentObject(RideStore())
}
