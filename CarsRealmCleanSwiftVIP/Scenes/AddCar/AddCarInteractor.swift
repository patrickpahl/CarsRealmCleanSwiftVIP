import UIKit

protocol AddCarBusinessLogic {
  func doSomething(request: AddCar.Something.Request)
}

protocol AddCarDataStore {
  //var name: String { get set }
}

class AddCarInteractor: AddCarBusinessLogic, AddCarDataStore {
  var presenter: AddCarPresentationLogic?
  var worker: AddCarWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: AddCar.Something.Request) {
    worker = AddCarWorker()
    worker?.doSomeWork()
    
    let response = AddCar.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
