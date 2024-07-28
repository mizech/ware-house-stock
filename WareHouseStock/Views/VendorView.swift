import SwiftUI
import SwiftData

struct VendorView: View {
    @Environment(\.modelContext) private var context
    @Bindable var vendor: Vendor
    @Query(sort: \Product.name) var allProducts: [Product]
    @State var vendorProducts = [Product]()
    
    @State private var isAddProductShown = false
    @State private var newProductName = ""
    @State private var newProductHint = ""
    @State private var newProductPrice = ""
    
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
            if vendorProducts.count > 0 {
                ProductsListView(products: vendorProducts)
            } else {
                Text("No products available, currently.")
                    .padding(.top, 5)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAddProductShown.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $isAddProductShown,
               content: {
            HStack {
                Spacer()
                Button(action: {
                    isAddProductShown.toggle()
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.largeTitle)
                }.padding(.trailing, 15)
                    .padding(.top, 15)
            }
            VStack(alignment: .leading, spacing: 20) {
                Section {
                    TextField("Name", text: $newProductName)
                        .textFieldStyle(.roundedBorder)
                    TextField("Hints", text: $newProductHint)
                        .textFieldStyle(.roundedBorder)
                    TextField("Price", text: $newProductPrice)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Add Product")
                        .font(.title)
                } footer: {
                    Button(action: {
                        guard newProductName.isEmpty == false,
                              newProductPrice.isEmpty == false else {
                            return
                        }
                        
                        let product = Product(
                            name: newProductName,
                            vendor: vendor,
                            hints: newProductHint,
                            price: Double(newProductPrice) ?? 0.0
                        )
                        
                        context.insert(product)
                        do {
                            try context.save()
                        } catch {
                            print(" -- Vendor-update failed -- ")
                            print(error)
                        }
                        
                        updateVendorProducts()
                        newProductName = ""
                        newProductHint = ""
                        newProductPrice = ""
                        isAddProductShown.toggle()
                    },
                           label: {
                        Text("Insert")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }).padding(.top, 15)
                    Button(action: {
                        newProductName = ""
                        newProductHint = ""
                        newProductPrice = ""
                    }, label: {
                        Text("Reset")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 15)
        })
        .onChange(of: allProducts, { oldValue, newValue in
            updateVendorProducts()
        })
        .onAppear() {
            updateVendorProducts()
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
        .navigationTitle("Vendor details")
        .padding()
    }
    
    func updateVendorProducts() {
        self.vendorProducts = self.allProducts.filter { product in
            product.vendor == vendor
        }
    }
}

#Preview {
    VendorView(
        vendor: Vendor(name: "Vendor 01", street: "Street 01", city: "City 01"))
}
