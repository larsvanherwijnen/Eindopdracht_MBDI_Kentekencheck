//
//  RideView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 20/02/2025.
//

import SwiftUI

struct Ride: Identifiable {
    let id = UUID()
    let name: String
}

struct RideView: View {
    @State private var rides: [Ride] = [
        Ride(name: "testride"),
        Ride(name: "testride2"),
    ]

    @State private var isShowingPopup = false
    @State private var newRideName = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Rit overzicht")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                List(rides) { ride in
                    VStack(alignment: .leading) {
                        Text(ride.name)
                            .font(.headline)
                    }
                    .padding(.vertical, 5)
                }

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
        }
    }

    private func addNewRide(name: String) {
        rides.append(Ride(name: name))
    }
}

#Preview {
    RideView()
}
