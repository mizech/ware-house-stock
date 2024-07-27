import SwiftUI

struct VendorView: View {
    @Bindable var vendor: Vendor
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Master data").font(.title)
            TextField("Name", text: $vendor.name)
                .textFieldStyle(.roundedBorder)
            TextField("Street", text: $vendor.street)
                .textFieldStyle(.roundedBorder)
            TextField("City", text: $vendor.city)
                .textFieldStyle(.roundedBorder)
            Text("Products").font(.title2).padding(.top, 20)
            List {
                ForEach(vendor.products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product),
                                   label: {
                        Text(product.name)
                    })
                }
            }.listStyle(.plain)
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Vendor details")
            .padding()
    }
}

#Preview {
    VendorView(vendor: Vendor(name: "Vendor 01", street: "Street 01", city: "City 01"))
}
