import UIKit
import RealmSwift

class CarsTableWorker {

    func doSomeWork() {

    }

    func getCarsFromRealm() -> Results<Car> {
        var cars: Results<Car>!

        let realm = try! Realm()
        cars = realm.objects(Car.self).sorted(byKeyPath: "make")
        print("Cars count = \(cars.count)")
        return cars
    }

}
