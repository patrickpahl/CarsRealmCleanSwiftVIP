import UIKit

protocol AddCarPresentationLogic {
    func presentCarAdded(response: AddCar.AddCar.Response)
    func presentUpdateFieldsIfCarExists(response: AddCar.UpdateFieldsIfCarExists.Response)
}

class AddCarPresenter: AddCarPresentationLogic {
    weak var viewController: AddCarDisplayLogic?

    // MARK: Do something

    func presentCarAdded(response: AddCar.AddCar.Response) {

        let carAdded = response.car
        let viewModel = AddCar.AddCar.ViewModel(car: carAdded)
        viewController?.displayNewCarAdded(viewModel: viewModel)
    }

    func presentUpdateFieldsIfCarExists(response: AddCar.UpdateFieldsIfCarExists.Response) {

        if response.car != nil {
        let car = response.car
        let viewModel = AddCar.UpdateFieldsIfCarExists.ViewModel(car: car, soldValue: nil)
        viewController?.displayUpdateFieldsIfCarExists(viewModel: viewModel)
        } else {
            let viewModel = AddCar.UpdateFieldsIfCarExists.ViewModel(car: nil, soldValue: false)
            viewController?.displayUpdateFieldsIfCarExists(viewModel: viewModel)
        }
    }
}
