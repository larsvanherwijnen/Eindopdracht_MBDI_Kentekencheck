//
//  RDWAPI.swift
//  MBDI_Eindopdracht_KentekenCheck
//
//  Created by Lars van Herwijnen on 18/02/2025.
//

import Foundation

struct Voertuig: Codable {
    let kenteken: String
    let voertuigsoort: String
    let merk: String
    let handelsbenaming: String
    let inrichting: String
    let aantalZitplaatsen: String
    let aantalDeuren: String
    let aantalWielen: String

    // Kleurinformatie
    let eersteKleur: String
    let tweedeKleur: String

    // Motorinformatie
    let aantalCilinders: String
    let cilinderinhoud: String
    let vermogenMassarijklaar: String

    // Massa en afmetingen
    let massaLedigVoertuig: String
    let massaRijklaar: String
    let toegestaneMaximumMassaVoertuig: String
    let maximumMassaSamenstelling: String
    let wielbasis: String
    let lengte: String
    let breedte: String
    let hoogteVoertuig: String

    // Trekkracht en snelheid
    let maximumMassaTrekkenOngeremd: String
    let maximumMassaTrekkenGeremd: String
    let maximaleConstructiesnelheid: String

    // Registratie en goedkeuring
    let type: String
    let typegoedkeuringsnummer: String
    let variant: String
    let uitvoering: String
    let catalogusprijs: String
    let brutoBPM: String
    let registratieDatumGoedkeuringAfschrijvingsmomentBPM: String
    let registratieDatumGoedkeuringAfschrijvingsmomentBPMDT: String

    // Datum gerelateerde gegevens
    let vervaldatumAPK: String
    let datumTenaamstelling: String
    let datumEersteToelating: String
    let datumEersteTenaamstellingInNederland: String
    let vervaldatumAPKDT: String
    let datumTenaamstellingDT: String
    let datumEersteToelatingDT: String
    let datumEersteTenaamstellingInNederlandDT: String

    // Overige kenmerken
    let wamVerzekerd: String
    let exportIndicator: String
    let openstaandeTerugroepactieIndicator: String
    let taxiIndicator: String
    let tellerstandoordeel: String
    let codeToelichtingTellerstandoordeel: String
    let jaarLaatsteRegistratieTellerstand: String
    let tenaamstellenMogelijk: String
    let zuinigheidsclassificatie: String
}

