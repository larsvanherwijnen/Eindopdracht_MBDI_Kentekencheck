import SwiftUI

struct CarView: View {
    let vehicle: Vehicle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(vehicle.merk) \(vehicle.handelsbenaming)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Kenteken: \(LicensePlateFormatter.format(vehicle.kenteken))")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                SectionHeader(title: "BASISKENMERKEN")
                VStack(spacing: 12) {
                    CarDetailRow(title: "Voertuigsoort", value: vehicle.voertuigsoort)
                    CarDetailRow(title: "APK Vervaldatum", value: vehicle.vervaldatum_apk)
                    CarDetailRow(title: "Datum Tenaamstelling", value: vehicle.datum_tenaamstelling)
                    CarDetailRow(title: "Catalogusprijs", value: vehicle.catalogusprijs)
                }
                .detailSection()
                
                SectionHeader(title: "Technische Gegevens")
                VStack(spacing: 12) {
                    CarDetailRow(title: "Bruto BPM", value: vehicle.bruto_bpm)
                    CarDetailRow(title: "Aantal Cilinders", value: vehicle.aantal_cilinders)
                    CarDetailRow(title: "Cilinderinhoud", value: vehicle.cilinderinhoud)
                    CarDetailRow(title: "Maximale Constructiesnelheid", value: vehicle.maximale_constructiesnelheid)
                }
                .detailSection()
                
                SectionHeader(title: "Afmetingen & Gewicht")
                VStack(spacing: 12) {
                    CarDetailRow(title: "Massa Ledig Voertuig", value: vehicle.massa_ledig_voertuig)
                    CarDetailRow(title: "Toegestane Maximum Massa Voertuig", value: vehicle.toegestane_maximum_massa_voertuig)
                    CarDetailRow(title: "Lengte", value: vehicle.lengte)
                    CarDetailRow(title: "Breedte", value: vehicle.breedte)
                    CarDetailRow(title: "Hoogte", value: vehicle.hoogte_voertuig)
                }
                .detailSection()
                
                SectionHeader(title: "Overige Gegevens")
                VStack(spacing: 12) {
                    CarDetailRow(title: "Inrichting", value: vehicle.inrichting)
                    CarDetailRow(title: "Aantal Zitplaatsen", value: vehicle.aantal_zitplaatsen)
                    CarDetailRow(title: "Kleur", value: formattedColors())
                    CarDetailRow(title: "Aantal Deuren", value: vehicle.aantal_deuren)
                    CarDetailRow(title: "Aantal Wielen", value: vehicle.aantal_wielen)
                }
                .detailSection()
            }
            .padding()
        }
    }
    
    private func formattedColors() -> String {
        var colors = [String]()
        if let firstColor = vehicle.eerste_kleur { colors.append(firstColor) }
        if let secondColor = vehicle.tweede_kleur { colors.append(secondColor) }
        return colors.joined(separator: ", ")
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.top, 10)
    }
}

struct CarDetailRow: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value ?? "-")
                .foregroundColor(.blue)
        }
    }
}

extension View {
    func detailSection() -> some View {
        self.padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}

#Preview {
    CarView(vehicle: Vehicle(
        kenteken: "AB-123-C",
        voertuigsoort: "Personenauto",
        merk: "Tesla",
        handelsbenaming: "Model 3",
        vervaldatum_apk: "2026-05-12",
        datum_tenaamstelling: "2023-01-10",
        bruto_bpm: "5000",
        inrichting: "Sedan",
        aantal_zitplaatsen: "5",
        eerste_kleur: "Zwart",
        tweede_kleur: "",
        aantal_cilinders: "4",
        cilinderinhoud: "2000",
        massa_ledig_voertuig: "1500",
        toegestane_maximum_massa_voertuig: "2000",
        massa_rijklaar: "1600",
        maximum_massa_trekken_ongeremd: "750",
        maximum_massa_trekken_geremd: "1500",
        datum_eerste_toelating: "2022-06-01",
        datum_eerste_tenaamstelling_in_nederland: "2023-01-10",
        catalogusprijs: "55000",
        wam_verzekerd: "Ja",
        maximale_constructiesnelheid: "250",
        aantal_deuren: "4",
        aantal_wielen: "4",
        lengte: "4694",
        breedte: "1850",
        hoogte_voertuig: "1443",
        type: "EV",
        typegoedkeuringsnummer: "XYZ123",
        variant: "Long Range",
        uitvoering: "AWD",
        tellerstandoordeel: "Correct",
        tenaamstellen_mogelijk: "Ja",
        zuinigheidsclassificatie: "A"
    ))
}
