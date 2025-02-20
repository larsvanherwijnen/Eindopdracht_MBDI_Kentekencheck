import SwiftUI

struct MainView: View {
    @State private var voertuig: Vehicle?

    var body: some View {
        VStack {
            if let voertuig = voertuig {
                Text("Kenteken: \(voertuig.kenteken)")
                    .font(.title2)
                    .bold()
                Text("Merk: \(voertuig.merk)")
                Text("Model: \(voertuig.handelsbenaming)")
                Text("Kleur: \(voertuig.eerste_kleur)")
                Text("Aantal Zitplaatsen: \(voertuig.aantal_zitplaatsen)")
                Text("Type: \(voertuig.type)")
                Text("APK Vervaldatum: \(voertuig.vervaldatum_apk)")
            } else {
                Text("Laden...")
            }
        }
        .padding()
        .onAppear(perform: loadData)
    }

    func loadData() {
        print("Test")
        let jsonString = """
        [
            {
                "kenteken": "S552PD",
                "voertuigsoort": "Personenauto",
                "merk": "BMW",
                "handelsbenaming": "218I",
                "vervaldatum_apk": "20270315",
                "datum_tenaamstelling": "20230315",
                "bruto_bpm": "6368",
                "inrichting": "sedan",
                "aantal_zitplaatsen": "5",
                "eerste_kleur": "WIT",
                "tweede_kleur": "Niet geregistreerd",
                "aantal_cilinders": "3",
                "cilinderinhoud": "1499",
                "massa_ledig_voertuig": "1350",
                "toegestane_maximum_massa_voertuig": "1905",
                "massa_rijklaar": "1450",
                "maximum_massa_trekken_ongeremd": "725",
                "maximum_massa_trekken_geremd": "1300",
                "datum_eerste_toelating": "20230315",
                "datum_eerste_tenaamstelling_in_nederland": "20230315",
                "catalogusprijs": "52685",
                "wam_verzekerd": "Ja",
                "maximale_constructiesnelheid": "215",
                "aantal_deuren": "4",
                "aantal_wielen": "4",
                "lengte": "453",
                "breedte": "180",
                "hoogte_voertuig": "142",
                "type": "F2GC",
                "typegoedkeuringsnummer": "e1*2007/46*2064*07",
                "variant": "11AK",
                "uitvoering": "IAW500L0",
                "tellerstandoordeel": "Logisch",
                "tenaamstellen_mogelijk": "Ja",
                "zuinigheidsclassificatie": "B"
            }
        ]
        """

        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error converting JSON string to Data")
            return
        }

        let decoder = JSONDecoder()
        do {
            let voertuigen = try decoder.decode([Vehicle].self, from: jsonData)
            DispatchQueue.main.async {
                self.voertuig = voertuigen.first
            }
        } catch {
            print("Decoding failed: \(error)")
        }
    }
}

#Preview {
    MainView()
}
