import UIKit

protocol AddCarBusinessLogic {
    func addCar(request: AddCar.AddCar.Request)
}

protocol AddCarDataStore {
    //var name: String { get set }
}

class AddCarInteractor: AddCarBusinessLogic, AddCarDataStore {
    var presenter: AddCarPresentationLogic?
    var worker: AddCarWorker?
    //var name: String = ""

    // MARK: Do something

    func addCar(request: AddCar.AddCar.Request) {
        worker = AddCarWorker()
        worker?.addCarToRealm(make: request.addCarFields.make, model: request.addCarFields.model, sold: request.addCarFields.sold)

        let response = AddCar.AddCar.Response()
        presenter?.presentCarAdded(response: response)
    }
}
