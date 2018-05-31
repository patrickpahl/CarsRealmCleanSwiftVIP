import UIKit
import RealmSwift

class AddCarWorker {

    func doSomeWork() {

    }

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
}


