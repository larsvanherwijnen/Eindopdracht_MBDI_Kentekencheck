import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("KENTEKENCHECK")
                .font(Font.custom("Kenteken", size: 30))
                .padding(.top)
            LicensePlateView()
            RideListView()
        }
        .padding(.horizontal)
    }


}

#Preview {
    MainView()
}
