import UIKit

enum AddCar {
    // MARK: Use cases

    struct AddCarFields {
        var make: String
        var model: String
        var sold: Bool
    }

    enum AddCar {
        struct Request {
            var addCarFields: AddCarFields
        }
        struct Response {
            var car: Car?
        }
        struct ViewModel {
            var car: Car?
        }
    }

    enum UpdateFieldsIfCarExists {
        struct Request {
        }
        struct Response {
            var car: Car?
            var soldValue: Bool?
        }
        struct ViewModel {
            var car: Car?
            var soldValue: Bool?
        }
    }

    enum UpdateCar {
        struct Request {
            var addCarFields: AddCarFields
        }
        struct Response {
            var car: Car?
        }
        struct ViewModel {
            var car: Car?
        }
    }

}
