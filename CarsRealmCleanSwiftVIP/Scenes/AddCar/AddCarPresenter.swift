import UIKit

protocol AddCarPresentationLogic
{
  func presentSomething(response: AddCar.Something.Response)
}

class AddCarPresenter: AddCarPresentationLogic
{
  weak var viewController: AddCarDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: AddCar.Something.Response)
  {
    let viewModel = AddCar.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
