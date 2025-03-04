//
//  LayoutView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 20/02/2025.
//

import SwiftUI

struct LayoutView: View {
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                MainView()
            }
            
            Tab("Ritten", systemImage: "car.fill") {
                RideView()
            }
        }
    }
}

#Preview {
    LayoutView()
}
