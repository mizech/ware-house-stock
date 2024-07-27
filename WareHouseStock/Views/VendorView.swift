import SwiftUI

struct VendorView: View {
    var vendor: Vendor
    
    var body: some View {
        VStack {
            Text(vendor.name)
                .font(.title)
            List {
                ForEach(vendor.products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product),
                                   label: {
                        Text(product.name)
                    })
                }
            }.listStyle(.plain)
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Vendor Details")
    }
}

#Preview {
    VendorView(vendor: Vendor(name: "Vendor 01", street: "Street 01", city: "City 01"))
}
