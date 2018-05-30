import UIKit
import RealmSwift

protocol CarsTableBusinessLogic {
    func doSomething(request: CarsTable.Something.Request)
    func getCars(request: CarsTable.GetCars.Request)
}

protocol CarsTableDataStore {
    //var name: String { get set }
    var allCars: Results<Car>? { get set }
}

class CarsTableInteractor: CarsTableBusinessLogic, CarsTableDataStore {
    var presenter: CarsTablePresentationLogic?
    var worker: CarsTableWorker?
    //var name: String = ""
    var allCars: Results<Car>?

    // MARK: Do something

    func doSomething(request: CarsTable.Something.Request) {
        worker = CarsTableWorker()
        worker?.doSomeWork()

        let response = CarsTable.Something.Response()
        presenter?.presentSomething(response: response)
    }

    func getCars(request: CarsTable.GetCars.Request) {

        worker = CarsTableWorker()
        let cars = worker?.getCarsFromRealm()
        allCars = cars

        let response = CarsTable.GetCars.Response(cars: cars)
        presenter?.presentGetCars(response: response)
    }

}
