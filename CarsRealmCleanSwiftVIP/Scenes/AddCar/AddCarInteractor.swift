import UIKit

protocol AddCarBusinessLogic {
    func addCar(request: AddCar.AddCar.Request)
    func updateFieldsIfCarExists(request: AddCar.UpdateFieldsIfCarExists.Request)
    func updateCar(request: AddCar.UpdateCar.Request)
}

protocol AddCarDataStore {
    var carToUpdate: Car? { get set }
}

class AddCarInteractor: AddCarBusinessLogic, AddCarDataStore {
    var presenter: AddCarPresentationLogic?
    var worker: AddCarWorker?

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
            let response = AddCar.UpdateFieldsIfCarExists.Response(car: carToUpdate, soldValue: nil)
            presenter?.presentUpdateFieldsIfCarExists(response: response)
        } else {
            let response = AddCar.UpdateFieldsIfCarExists.Response(car: nil, soldValue: false)
            presenter?.presentUpdateFieldsIfCarExists(response: response)
        }
    }

    func updateCar(request: AddCar.UpdateCar.Request) {

        guard let carToUpdate = carToUpdate else { return }
        worker = AddCarWorker()
        worker?.updateCarInRealm(car: carToUpdate, make: request.addCarFields.make, model: request.addCarFields.model, sold: request.addCarFields.sold)

        let response = AddCar.UpdateCar.Response(car: carToUpdate)
        presenter?.presentUpdateCar(response: response)
    }

}
