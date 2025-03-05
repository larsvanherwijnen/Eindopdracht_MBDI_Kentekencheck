//
//  RideStore.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 25/02/2025.
//

import Foundation

class RideStore: ObservableObject {
    @Published private(set) var rides: [Ride] = []
    
    init() {
        loadRides()
    }
    
    func addRide(name: String, licensePlates: [String]) {
        let newRide = Ride(name: name, licensePlates: licensePlates)
        rides.append(newRide)
        saveRides()
    }
    
    func deleteRide(at offsets: IndexSet) {
        rides.remove(atOffsets: offsets)
        saveRides()
    }
    
    private func saveRides() {
        if let encoded = try? JSONEncoder().encode(rides) {
            UserDefaults.standard.set(encoded, forKey: "SavedRides")
        }
    }
    
    private func loadRides() {
        if let savedRides = UserDefaults.standard.data(forKey: "SavedRides"),
           let decodedRides = try? JSONDecoder().decode([Ride].self, from: savedRides) {
            self.rides = decodedRides
        }
    }
}
