import UIKit

protocol CarsTableBusinessLogic
{
  func doSomething(request: CarsTable.Something.Request)
}

protocol CarsTableDataStore
{
  //var name: String { get set }
}

class CarsTableInteractor: CarsTableBusinessLogic, CarsTableDataStore
{
  var presenter: CarsTablePresentationLogic?
  var worker: CarsTableWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: CarsTable.Something.Request)
  {
    worker = CarsTableWorker()
    worker?.doSomeWork()
    
    let response = CarsTable.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
