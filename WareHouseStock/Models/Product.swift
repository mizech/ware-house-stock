import Foundation
import SwiftData

@Model
class Product {
    var name: String
    var vendor: Vendor
    var hints = ""
    var price = 0.0
    
    init(name: String, vendor: Vendor, hints: String = "", price: Double = 0.0) {
        self.name = name
        self.vendor = vendor
        self.hints = hints
        self.price = price
    }
}

