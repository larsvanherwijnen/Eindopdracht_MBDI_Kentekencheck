import SwiftUI

struct MainView: View {
    @State private var rides: [Ride] = []

    var body: some View {
        VStack {
            Text("KENTEKENCHECK")
                .font(Font.custom("Kenteken", size: 30))
                .padding(.top)
            LicensePlateView()
           
            List(rides) { ride in
                VStack(alignment: .leading) {
                    Text(ride.name)
                        .font(.headline)
                }
                .padding(.vertical, 5)
            }
        }
        .padding(.horizontal)
    }


}

#Preview {
    MainView()
}
