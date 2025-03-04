import SwiftUI

struct MainView: View {
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

            RideListView()

        }
        .padding(.horizontal)
    }


}

#Preview {
    MainView()
}
