import UIKit
import RealmSwift

enum CarsTable {
    // MARK: Use cases

    enum GetCars {
        struct Request {
            
        }
        struct Response {
            var cars: Results<Car>?
        }
        struct ViewModel {
            struct DisplayedCar {
                var make: String
                var model: String
                var sold: Bool
            }

            var displayedCars = [DisplayedCar]()
        }
    }

    enum SelectCar {
        struct Request {
            var indexPath: IndexPath
        }
        struct Response {
            var indexPath: IndexPath
            var segueIdentifier: String
        }
        struct ViewModel {
            var indexPath: IndexPath
            var segueIdentifier: String
        }
    }

}
