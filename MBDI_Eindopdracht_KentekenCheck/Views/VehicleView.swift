import SwiftUI

struct VehicleView: View {
    let vehicle: Vehicle?
    
    var body: some View {
        Text(vehicle!.kenteken)
    }
}
