import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Vendor.name) private var vendors: [Vendor]
    
    @State private var isAddSheetShown = false
    @State private var newVendorName = ""
    @State private var newVendorStreet = ""
    @State private var newVendorCity = ""
    
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
            .sheet(isPresented: $isAddSheetShown,
                   content: {
                HStack {
                    Spacer()
                    Button(action: {
                        isAddSheetShown.toggle()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.largeTitle)
                    }.padding(.trailing, 15)
                        .padding(.top, 15)
                }
                VStack(alignment: .leading, spacing: 20) {
                    Section {
                        TextField("Name", text: $newVendorName)
                            .textFieldStyle(.roundedBorder)
                        TextField("Street", text: $newVendorStreet)
                            .textFieldStyle(.roundedBorder)
                        TextField("City", text: $newVendorCity)
                            .textFieldStyle(.roundedBorder)
                    } header: {
                        Text("Add Vendor")
                            .font(.title)
                    } footer: {
                        Button(action: {
                            guard newVendorName.isEmpty == false else {
                                return
                            }
                            
                            let vendor = Vendor(
                                name: newVendorName,
                                street: newVendorStreet,
                                city: newVendorCity
                            )
                            
                            context.insert(vendor)
                            do {
                                try context.save()
                            } catch {
                                print(" -- Insert vendor failed -- ")
                                print(error)
                            }
                            
                            newVendorName = ""
                            newVendorStreet = ""
                            newVendorCity = ""
                            isAddSheetShown.toggle()
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
                            newVendorName = ""
                            newVendorStreet = ""
                            newVendorCity = ""
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
                Spacer()
            })
        }
    }
}

#Preview {
    ContentView()
}
