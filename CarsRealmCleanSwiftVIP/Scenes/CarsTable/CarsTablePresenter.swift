import UIKit

protocol CarsTablePresentationLogic
{
  func presentSomething(response: CarsTable.Something.Response)
}

class CarsTablePresenter: CarsTablePresentationLogic
{
  weak var viewController: CarsTableDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: CarsTable.Something.Response)
  {
    let viewModel = CarsTable.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
