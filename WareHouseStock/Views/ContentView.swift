import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var vendors: [Vendor]
    
    @State private var isAddSheetShown = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vendors, id: \.self) { vendor in
                    NavigationLink(destination: VendorView(vendor: vendor)) {
                        Text(vendor.name)
                    }
                }.onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(vendors[index])
                    }
                })
            }
            .listStyle(.plain)
            .padding()
            .onAppear() {
//                for i in 0..<5 {
//                    let vendor = Vendor(name: "Vendor Number \(i)", street: "Street \(i)", city: "City \(i)")
//                    let product1 = Product(name: "Product 01", vendor: vendor)
//                    let product2 = Product(name: "Product 02", vendor: vendor)
//                    let product3 = Product(name: "Product 03", vendor: vendor)
//                    context.insert(product1)
//                    context.insert(product2)
//                    context.insert(product3)
//                }
            }
            .navigationTitle("Vendors")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddSheetShown.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $isAddSheetShown, content: {
                Button(action: {
                    let vendor = Vendor(name: "Vendor \(Date.timeIntervalSinceReferenceDate)",
                                        street: "Street 01", city: "City 01")
                    let product1 = Product(name: "Product 01", vendor: vendor)
                    let product2 = Product(name: "Product 02", vendor: vendor)
                    let product3 = Product(name: "Product 03", vendor: vendor)
                    context.insert(product1)
                    context.insert(product2)
                    context.insert(product3)
                    isAddSheetShown.toggle()
                }, label: {
                    Text("Insert Vendor")
                })
            })
        }
    }
}

#Preview {
    ContentView()
}
