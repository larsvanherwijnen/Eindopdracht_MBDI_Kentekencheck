//
//  VehicleView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Mike de Groot on 18/02/2025.
//
import SwiftUI

struct VehicleView: View {
    let vehicle: Vehicle?
    
    var body: some View {
        Text(vehicle!.kenteken)
    }
}
