//
//  MBDI_Eindopdracht_KentekenCheckApp.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Lars van Herwijnen on 12/02/2025.
//

import SwiftUI

@main
struct MBDI_Eindopdracht_KentekenCheckApp: App {
    @StateObject private var rideStore = RideStore()
    
    var body: some Scene {
        WindowGroup {
            LayoutView()

                .environmentObject(rideStore)
        }
    }
}
