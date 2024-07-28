import SwiftUI

struct ProductView: View {
    @Environment(\.modelContext) private var context
    @Bindable var product: Product
    @State var updatedPrice = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Master data").font(.title)
            TextField("Name", text: $product.name)
                .textFieldStyle(.roundedBorder)
            TextField("Hints", text: $product.hints)
                .textFieldStyle(.roundedBorder)
            TextField("Price", text: $updatedPrice)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }.padding()
            .onChange(of: updatedPrice, { oldValue, newValue in
                product.price = Double(newValue) ?? 0.0
            })
            .onAppear() {
                updatedPrice = String(product.price)
            }
            .onDisappear() {
                do {
                    try context.save()
                } catch {
                    print(" -- Vendor-update failed -- ")
                    print(error)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Product details")
    }
}

#Preview {
    ProductView(
        product: Product(
            name: "Product 01",
            vendor: Vendor(name: "Vendor Name 01", street: "Street 01", city: "City 01")
        )
    )
}
