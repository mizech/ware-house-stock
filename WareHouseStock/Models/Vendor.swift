import Foundation
import SwiftData

@Model
class Vendor {
    var name: String
    var street: String
    var city: String
    @Relationship(deleteRule: .cascade, inverse: \Product.vendor)
    var products = [Product]()
    
    init(name: String, street: String, city: String) {
        self.name = name
        self.street = street
        self.city = city
    }
}
