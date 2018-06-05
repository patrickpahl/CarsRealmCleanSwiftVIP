import UIKit
import RealmSwift

class AddCarWorker {

    func addCarToRealm(make: String, model: String, sold: Bool) {
        let realm = try! Realm()
        let car = Car()
        car.make = make
        car.model = model
        car.sold = sold

        try! realm.write {
            realm.add(car)
        }
    }

    func updateCarInRealm(car: Car, make: String, model: String, sold: Bool) {
        let realm = try! Realm()
        try! realm.write {
            car.make = make
            car.model = model
            car.sold = sold
        }
    }

}
