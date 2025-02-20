//
//  LicensePlateView.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Lars van Herwijnen on 20/02/2025.
//

import SwiftUI

struct LicensePlateView: View {
    @StateObject private var rdwManager = RDWManager()
    @State private var kenteken: String = ""

    var body: some View {
        VStack {
            ZStack {
                Image("kentekenplaat")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)

                TextField("Voer kenteken in", text: $kenteken)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 200, height: 50)
                    .textInputAutocapitalization(.characters)
                    .onSubmit {
                        if kenteken.count == 6 {
                            rdwManager.fetchData(for: kenteken)
                        }
                    }
            }
            .padding()

            if let errorMessage = rdwManager.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else if let voertuig = rdwManager.voertuig {
                VStack {
                    Text("Merk: \(voertuig.merk)")
                    Text("Model: \(voertuig.handelsbenaming)")
                    Text("APK Vervaldatum: \(voertuig.vervaldatum_apk)")
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    LicensePlateView()
}
