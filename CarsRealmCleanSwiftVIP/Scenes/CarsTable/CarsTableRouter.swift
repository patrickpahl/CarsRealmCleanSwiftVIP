import UIKit

@objc protocol CarsTableRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CarsTableDataPassing {
  var dataStore: CarsTableDataStore? { get }
}

class CarsTableRouter: NSObject, CarsTableRoutingLogic, CarsTableDataPassing {
  weak var viewController: CarsTableViewController?
  var dataStore: CarsTableDataStore?
  
  // MARK: Routing

    func routeToAddCarSegue(segue: UIStoryboardSegue?) {

        if let segue = segue, let destination = segue.destination as? AddCarViewController, var destinationDataStore = destination.router?.dataStore, let sourceDataStore = dataStore {

        }

    }

    func passDataToAddCar(source: CarsTableDataStore, destination: inout AddCarDataStore) {

        destination.car = source.



    }
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: CarsTableViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CarsTableDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
