import UIKit

protocol AddCarDisplayLogic: class {
    func displayNewCarAdded(viewModel: AddCar.AddCar.ViewModel)
    func displayUpdateFieldsIfCarExists(viewModel: AddCar.UpdateFieldsIfCarExists.ViewModel)
    func displayUpdateCar(viewModel: AddCar.UpdateCar.ViewModel)
}

class AddCarViewController: UIViewController, AddCarDisplayLogic {
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var soldSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    var interactor: AddCarBusinessLogic?
    var router: (NSObjectProtocol & AddCarRoutingLogic & AddCarDataPassing)?

    var soldValue = Bool()
    var car: Car?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = AddCarInteractor()
        let presenter = AddCarPresenter()
        let router = AddCarRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseKeyboardGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateFieldsIfCarExisits()
    }

    func setupCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func addCar() {
        guard makeTextField.text != "" else {
            let request = AddCar.AddCar.Request(addCarFields: nil, errorMessage: "Please enter a make.")
            interactor?.addCar(request: request)
            return
        }

        guard modelTextField.text != "" else {
            let request = AddCar.AddCar.Request(addCarFields: nil, errorMessage: "Please enter a model.")
            interactor?.addCar(request: request)
            return
        }

        guard let makeText = makeTextField.text,
        let modelText = modelTextField.text else { return }

        let carFields = AddCar.AddCarFields(make: makeText, model: modelText, sold: soldValue)

        let request = AddCar.AddCar.Request(addCarFields: carFields, errorMessage: nil)
        interactor?.addCar(request: request)
    }

    func displayNewCarAdded(viewModel: AddCar.AddCar.ViewModel) {
        if viewModel.errorMessage != nil {
            let alertController = UIAlertController(title: "Error", message: viewModel.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }

    func updateCar() {
        guard let makeText = makeTextField.text,
            let modelText = modelTextField.text else { return }

        let carFields = AddCar.AddCarFields(make: makeText, model: modelText, sold: soldValue)

        let request = AddCar.UpdateCar.Request(addCarFields: carFields)
        interactor?.updateCar(request: request)
    }

    func displayUpdateCar(viewModel: AddCar.UpdateCar.ViewModel) {
        car = viewModel.car
        if let car = car {
            print("Updated car! \(car.make), \(car.model), Sold: \(car.sold)")
            self.navigationController?.popViewController(animated: true)
        }
    }

    func updateFieldsIfCarExisits() {
        let request = AddCar.UpdateFieldsIfCarExists.Request()
        interactor?.updateFieldsIfCarExists(request: request)
    }

    func displayUpdateFieldsIfCarExists(viewModel: AddCar.UpdateFieldsIfCarExists.ViewModel) {

        if viewModel.car != nil {
            guard let carToUpdate = viewModel.car else { return }
            car = carToUpdate
            makeTextField.text = carToUpdate.make
            modelTextField.text = carToUpdate.model
            soldSwitch.isOn = carToUpdate.sold
            soldValue = carToUpdate.sold
        } else {
            guard let soldValue = viewModel.soldValue else { return }
            soldSwitch.isOn = soldValue
            self.soldValue = soldValue
        }
    }

    // Actions:

    @IBAction func soldSwitchValueChanged(_ sender: UISwitch) {
        soldValue = soldSwitch.isOn ? true : false
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {

        if car != nil {
            updateCar()
        } else {
            addCar()
        }
    }

}
