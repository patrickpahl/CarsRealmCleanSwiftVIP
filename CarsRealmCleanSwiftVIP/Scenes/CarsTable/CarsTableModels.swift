import UIKit
import RealmSwift

enum CarsTable {
    // MARK: Use cases

    enum Something {
        struct Request {

        }
        struct Response {

        }
        struct ViewModel {

        }
    }

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

}
