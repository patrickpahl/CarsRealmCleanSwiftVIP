import UIKit

protocol CarsTablePresentationLogic {
    func presentSomething(response: CarsTable.Something.Response)
    func presentGetCars(response: CarsTable.Cars.Response)
}

class CarsTablePresenter: CarsTablePresentationLogic {
    weak var viewController: CarsTableDisplayLogic?

    // MARK: Do something

    func presentSomething(response: CarsTable.Something.Response) {

    }

    func presentGetCars(response: CarsTable.Cars.Response) {

        let viewModel = CarsTable.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)

    }

}
