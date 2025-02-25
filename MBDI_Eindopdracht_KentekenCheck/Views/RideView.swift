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
                        VStack(alignment: .leading) {
                            Text(ride.name)
                                .font(.headline)
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
                VStack(spacing: 20) {
                    Text("Maak rit aan")
                        .font(.title2)
                        .fontWeight(.bold)

                    TextField("Rit naam", text: $newRideName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        addNewRide(name: newRideName)
                        newRideName = ""
                        isShowingPopup = false
                    }) {
                        Text("Rit aanmaken")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                    }

                    Button(action: {
                        isShowingPopup = false
                    }) {
                        Text("Annuleren")
                            .font(.headline)
                            .foregroundStyle(.red)
                            .padding()
                    }
                }
                .padding()
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

    private func addNewRide(name: String) {
        rideStore.addRide(name: name)
    }

    private func deleteRide(at offsets: IndexSet) {
        rideStore.deleteRide(at: offsets)
    }
}

#Preview {
    RideView()
}
