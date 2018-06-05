import UIKit
import RealmSwift

protocol CarsTableBusinessLogic {
    func getCars(request: CarsTable.GetCars.Request)
    func selectCar(request: CarsTable.SelectCar.Request)
}

protocol CarsTableDataStore {
    var allCars: Results<Car>? { get set }
    var selectedCar: Car? { get set }
}

class CarsTableInteractor: CarsTableBusinessLogic, CarsTableDataStore {
    var presenter: CarsTablePresentationLogic?
    var worker: CarsTableWorker?
    var allCars: Results<Car>?
    var selectedCar: Car?

    func getCars(request: CarsTable.GetCars.Request) {

        worker = CarsTableWorker()
        let cars = worker?.getCarsFromRealm()
        allCars = cars

        let response = CarsTable.GetCars.Response(cars: cars)
        presenter?.presentGetCars(response: response)
    }

    func selectCar(request: CarsTable.SelectCar.Request) {
        guard let allCars = allCars else { return }

        let car = allCars[request.indexPath.row]
        selectedCar = car
        let addCarSegue = "AddCarSegue"
        let response = CarsTable.SelectCar.Response(indexPath: request.indexPath, segueIdentifier: addCarSegue)
        presenter?.presentSelectCar(response: response)
    }

}
