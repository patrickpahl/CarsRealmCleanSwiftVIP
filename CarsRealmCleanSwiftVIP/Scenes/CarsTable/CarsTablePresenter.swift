import UIKit

protocol CarsTablePresentationLogic {
    func presentGetCars(response: CarsTable.GetCars.Response)
    func presentSelectCar(response: CarsTable.SelectCar.Response)
}

class CarsTablePresenter: CarsTablePresentationLogic {
    weak var viewController: CarsTableDisplayLogic?

    func presentGetCars(response: CarsTable.GetCars.Response) {
        guard let cars = response.cars else { return }

        var displayedCars = [CarsTable.GetCars.ViewModel.DisplayedCar]()
        for car in cars {
            let make = car.make
            let model = car.model
            let sold = car.sold
            let displayedCar = CarsTable.GetCars.ViewModel.DisplayedCar(make: make, model: model, sold: sold)
            displayedCars.append(displayedCar)
        }
        let viewModel = CarsTable.GetCars.ViewModel(displayedCars: displayedCars)
        viewController?.displayAllCars(viewModel: viewModel)
    }

    func presentSelectCar(response: CarsTable.SelectCar.Response) {

        let viewModel = CarsTable.SelectCar.ViewModel(indexPath: response.indexPath, segueIdentifier: response.segueIdentifier)
        viewController?.displaySelectCar(viewModel: viewModel)
    }

}
