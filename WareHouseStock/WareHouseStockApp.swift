import SwiftUI
import SwiftData

@main
struct WareHouseStockApp: App {
    @AppStorage("isOnBoardViewShown") var isOnBoardViewShown = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Vendor.self])
                .fullScreenCover(isPresented: $isOnBoardViewShown) {
                                    OnBoardView(isOnBoardViewShown: $isOnBoardViewShown)
                                }
        }
    }
}
