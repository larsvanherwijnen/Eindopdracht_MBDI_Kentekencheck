//
//  RideView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 20/02/2025.
//

import SwiftUI

struct RideView: View {
    @State private var rides: [Ride] = []

    @State private var isShowingPopup = false
    @State private var newRideName = ""

    init() {
        _rides = State(initialValue: loadRides())
    }

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
        let newRide = Ride(name: name)
        rides.append(newRide)
        saveRides()
    }

    private func saveRides() {
        if let encoded = try? JSONEncoder().encode(rides) {
            UserDefaults.standard.set(encoded, forKey: "SavedRides")
        }
    }

    private func loadRides() -> [Ride] {
        if let savedRides = UserDefaults.standard.data(forKey: "SavedRides"),
            let decodedRides = try? JSONDecoder().decode(
                [Ride].self, from: savedRides)
        {
            return decodedRides
        }
        return []
    }
}

#Preview {
    RideView()
}
