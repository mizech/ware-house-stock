import SwiftUI

struct ProductView: View {
    var product: Product
    
    var body: some View {
        Text(product.name)
    }
}

#Preview {
    ProductView(product: Product(name: "Product 01", vendor: Vendor(name: "Vendor Name 01", street: "Street 01", city: "City 01")))
}
