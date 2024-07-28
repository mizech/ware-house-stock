import SwiftUI

struct ProductsListView: View {
    @Environment(\.modelContext) private var context
    var products: [Product]
    
    var body: some View {
        List {
            ForEach(products) { product in
                NavigationLink(destination: ProductView(product: product),
                               label: {
                    Text(product.name)
                })
            }.onDelete { indexSet in
                for index in indexSet {
                    context.delete(products[index])
                }
                
                do {
                    try context.save()
                } catch {
                    print(" -- Saving vendor.products failed -- ")
                    print(error)
                }
            }
        }.listStyle(.plain)
    }
}

#Preview {
    ProductsListView(products: [Product]())
}
