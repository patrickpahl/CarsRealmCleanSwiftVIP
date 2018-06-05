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

        let car = response.car
        let viewModel = AddCar.UpdateFieldsIfCarExists.ViewModel(car: car)
        viewController?.displayUpdateFieldsIfCarExists(viewModel: viewModel)
    }
}
