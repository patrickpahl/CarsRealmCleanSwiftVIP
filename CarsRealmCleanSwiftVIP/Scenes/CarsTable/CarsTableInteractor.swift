import UIKit

protocol CarsTableBusinessLogic {
    func doSomething(request: CarsTable.Something.Request)
    func getCars(request: CarsTable.Cars.Request)
}

protocol CarsTableDataStore {
    //var name: String { get set }
}

class CarsTableInteractor: CarsTableBusinessLogic, CarsTableDataStore {
    var presenter: CarsTablePresentationLogic?
    var worker: CarsTableWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: CarsTable.Something.Request) {
        worker = CarsTableWorker()
        worker?.doSomeWork()

        let response = CarsTable.Something.Response()
        presenter?.presentSomething(response: response)
    }

    func getCars(request: CarsTable.Cars.Request) {
        let response =
        presenter.
    }

}
