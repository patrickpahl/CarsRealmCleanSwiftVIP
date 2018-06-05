import UIKit

protocol AddCarBusinessLogic {
    func addCar(request: AddCar.AddCar.Request)
    func updateFieldsIfCarExists(request: AddCar.UpdateFieldsIfCarExists.Request)
}

protocol AddCarDataStore {
    var car: Car? { get set }
    var carToUpdate: Car? { get set }
}

class AddCarInteractor: AddCarBusinessLogic, AddCarDataStore {
    var presenter: AddCarPresentationLogic?
    var worker: AddCarWorker?

    var car: Car?
    var carToUpdate: Car?

    // MARK: Do something

    func addCar(request: AddCar.AddCar.Request) {
        worker = AddCarWorker()
        worker?.addCarToRealm(make: request.addCarFields.make, model: request.addCarFields.model, sold: request.addCarFields.sold)

        let response = AddCar.AddCar.Response()
        presenter?.presentCarAdded(response: response)
    }

    func updateFieldsIfCarExists(request: AddCar.UpdateFieldsIfCarExists.Request) {
        if carToUpdate != nil {
            let response = AddCar.UpdateFieldsIfCarExists.Response(car: carToUpdate)
            presenter?.presentUpdateFieldsIfCarExists(response: response)
        }
    }

}
