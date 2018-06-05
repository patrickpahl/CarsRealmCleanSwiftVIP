import UIKit

protocol AddCarDisplayLogic: class {
    func displayNewCarAdded(viewModel: AddCar.AddCar.ViewModel)
    func displayUpdateFieldsIfCarExists(viewModel: AddCar.UpdateFieldsIfCarExists.ViewModel)
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
        //// TODO: update when enabling update car
        // if car to update available, car.sold. ELSE soldvalue = false
        //soldValue = false
        //soldSwitch.isOn = false
    }

    func setupCloseKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func addCar() {
        guard let makeText = makeTextField.text,
            let modelText = modelTextField.text else { return }

        let carFields = AddCar.AddCarFields(make: makeText, model: modelText, sold: soldValue)

        let request = AddCar.AddCar.Request(addCarFields: carFields)
        interactor?.addCar(request: request)
    }

    func displayNewCarAdded(viewModel: AddCar.AddCar.ViewModel) {
        car = viewModel.car
        if let car = car {
            print("NEW CAR ADDED: \(car.make) \(car.model), sold? \(car.sold)")
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
        addCar()
    }

}
