import UIKit

protocol AddCarDisplayLogic: class {

}

class AddCarViewController: UIViewController, AddCarDisplayLogic {

    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var soldSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    var interactor: AddCarBusinessLogic?
    var router: (NSObjectProtocol & AddCarRoutingLogic & AddCarDataPassing)?

    var soldValue = Bool()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: update when enabling update car
        soldValue = false
        soldSwitch.isOn = false
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func addCar() {

        guard let makeText = makeTextField.text,
            let modelText = modelTextField.text,
            let sold = soldValue else { return }

        let carFields = AddCar.AddCarFields(make: makeText, model: modelText, sold: soldValue)

        let request = AddCar.AddCar.Request(addCarFields: carFields)
        interactor.
    }

    // Actions:

    @IBAction func soldSwitchValueChanged(_ sender: UISwitch) {
        soldValue = soldSwitch.isOn ? true : false
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        addCar()
    }

}
