import UIKit
import RealmSwift

protocol CarsTableDisplayLogic: class {
    func displaySomething(viewModel: CarsTable.Something.ViewModel)
    func displayAllCars(viewModel: CarsTable.GetCars.ViewModel)
}

class CarsTableViewController: UIViewController, CarsTableDisplayLogic, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    ///var cars: Results<Car>?
    var cars = [CarsTable.GetCars.ViewModel.DisplayedCar]()

    var interactor: CarsTableBusinessLogic?
    var router: (NSObjectProtocol & CarsTableRoutingLogic & CarsTableDataPassing)?

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
        let interactor = CarsTableInteractor()
        let presenter = CarsTablePresenter()
        let router = CarsTableRouter()
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
        doSomething()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        getCars()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = CarsTable.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: CarsTable.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }

    func getCars() {
        let request = CarsTable.GetCars.Request()
        interactor?.getCars(request: request)

    }

    func displayAllCars(viewModel: CarsTable.GetCars.ViewModel) {
        cars = viewModel.displayedCars
        tableView.reloadData()
    }

    // TableView Funcs

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath)

        let car = cars[indexPath.row]

        cell.textLabel?.text = car.make + " " + car.model
        cell.detailTextLabel?.text = "\(car.sold)"

        return cell
    }

}
