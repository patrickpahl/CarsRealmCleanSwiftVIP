import UIKit
import RealmSwift

protocol CarsTableDisplayLogic: class {
    func displaySomething(viewModel: CarsTable.Something.ViewModel)
}

class CarsTableViewController: UIViewController, CarsTableDisplayLogic, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var cars: Results<Car>?

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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


        //reload data
    }

    // TableView Funcs

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let cars = cars {
            return cars.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath)

        guard let cars = cars else { return UITableViewCell() }

        let car = cars[indexPath.row]

        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""

        return cell
    }

}
