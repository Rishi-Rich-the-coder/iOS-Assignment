//
//  MainViewController.swift
//  DefineLabsAssignment
//
//  Created by Rishikesh Yadav on 3/13/21.
//

import UIKit

class MainViewController: UIViewController {
  
    @IBOutlet weak var locationsTableView: UITableView!
    var networkManager = NetworkManager()
    
    let transition = SlideInTransition()
    var selectedLocations = [Venue]()
    var allLocations = [Venue]()
    var tableViewData = [Venue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocations()
        networkManager.delegate = self
        networkManager.performRequest()
        // network call here.
        
    }
    
    func setupLocations() {
        tableViewData = allLocations
        selectedLocations = allLocations
        DispatchQueue.main.async {
            self.locationsTableView.reloadData()
        }

    }


    @IBAction func didTapSelectionButton(_ sender: UIBarButtonItem) {
        
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SideMenuViewController") as? SideMenuViewController else { return }
        controller.didTapMenuTyep = { menuType in
            self.transitionToNewView(for: menuType)
        }
        controller.modalPresentationStyle = .overCurrentContext
        controller.transitioningDelegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func transitionToNewView(for menuType: MenuList) {
        switch menuType {
        case .All:
            // can add a network call here as well, but it will call the API everytime user switches.
            tableViewData = allLocations
         
        case .selected:
            tableViewData = selectedLocations

            print("Selected types")
        }
        locationsTableView.reloadData()
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationDetailsTableViewCell") as? LocationDetailsTableViewCell else { return UITableViewCell() }
        let responseInstance = tableViewData[indexPath.row]
        cell.titleLabel.text = responseInstance.name
        cell.accessoryType = .checkmark
        cell.tintColor = responseInstance.isVenueSaved ? .green : .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let responseInstance = tableViewData[indexPath.row]
        let isVenueSelected = !responseInstance.isVenueSaved
        tableViewData[indexPath.row].isVenueSaved = isVenueSelected
        if let cell = tableView.cellForRow(at: indexPath) as? LocationDetailsTableViewCell {
            cell.tintColor = isVenueSelected ? .green : .lightGray
        }
    }
}

extension MainViewController: NetworkManagerDelegate {
    func didUpdateVenueData(with data: ResponseData?) {
        guard let venues = data?.venues else { return }
        allLocations = venues
        setupLocations()
    }
}
