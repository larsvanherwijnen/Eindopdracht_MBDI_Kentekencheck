import SwiftUI

struct LicensePlateInputView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var licensePlate: String

    var body: some View {
        ZStack {
            Image("Kentekenplaat")
                .resizable()
                .scaledToFit()
                .frame(height: 100)

            TextField(
                "",
                text: $licensePlate,
                prompt: Text("Voer kenteken in")
                    .font(.system(size: 24))
                    .fontWeight(.regular)
                    .foregroundStyle(Color.licensePlateInput)
            )
            .multilineTextAlignment(.center)
            .font(Font.custom("Kenteken", size: 30))
            .foregroundStyle(Color.black)
            .tint(Color.black)
            .frame(width: 200, height: 50)
            .textInputAutocapitalization(.characters)
        }
        .padding()
    }
}

#Preview {
    LicensePlateInputView(licensePlate: .constant(""))
}
