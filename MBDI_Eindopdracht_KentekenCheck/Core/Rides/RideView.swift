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
                VStack(spacing: 20) {
                    Text("Maak rit aan")
                        .font(.title2)
                        .fontWeight(.bold)

                    TextField("Rit naam", text: $newRideName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                                Text("Kentekenplaten (optioneel)")
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                ForEach(licensePlates.indices, id: \.self) { index in
                                    HStack {
                                        TextField("Kentekenplaat \(index + 1)", text: $licensePlates[index])
                                            .textFieldStyle(RoundedBorderTextFieldStyle())

                                        Button(action: {
                                            licensePlates.remove(at: index)
                                        }) {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }

                                Button(action: {
                                    licensePlates.append("")
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle")
                                        Text("Kentekenplaat toevoegen")
                                    }
                                    .foregroundColor(.blue)
                                }
                                .padding(.top, 5)
                            }
                            .padding(.horizontal)

                    
                    Button(action: {
                        addNewRide(name: newRideName, licensePlates: licensePlates)
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

    private func addNewRide(name: String, licensePlates: [String]) {
        rideStore.addRide(name: name, licensePlates: licensePlates)
    }

    private func deleteRide(at offsets: IndexSet) {
        rideStore.deleteRide(at: offsets)
    }
}

#Preview {
    RideView()
        .environmentObject(RideStore())
}
