import SwiftUI
import SwiftData

@main
struct WareHouseStockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Vendor.self])
        }
    }
}
