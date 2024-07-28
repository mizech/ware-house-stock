import SwiftUI

struct OnBoardView: View {
    @Binding var isOnBoardViewShown: Bool
    
    var body: some View {
        ScrollView {
            Text("WareHouseStock")
                .font(.title)
                .padding(.bottom, 12)
            Text("Usage-instructions")
                .font(.title2)
                .padding(.bottom, 10)
            VStack(alignment: .leading, spacing: 8) {
                Text("Use the + button to add vendors.")
                Text("Tap on a vendor for to navigate into the vendor-details view.")
                Text("Update the vendor-master data by using the text-fields.")
                Text("Use the + button within the vendor-details view to add products.")
                Text("Tap on a product in the list for to navigate into the product-details view.")
                Text("Update the product-master data by using the text-fields.")
                Text("Use left-swipe on the vendors-/products-lists to delete entities.")
                Button(action: {
                    isOnBoardViewShown.toggle()
                }, label: {
                    Text("I got it. Let's start!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }).padding(.top, 25)
            }
        }.padding()
    }
}

#Preview {
    OnBoardView(isOnBoardViewShown: .constant(true))
}
