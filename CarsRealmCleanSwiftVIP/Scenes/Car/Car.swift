import Foundation
import RealmSwift

class Car: Object {

    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var make = "BMW"
    @objc dynamic var model = "328i"
    @objc dynamic var sold = false

    override static func primaryKey() -> String? {
        return "uuid"
    }

    var makeAndModel: String {
        return make + " " + model
    }
}
