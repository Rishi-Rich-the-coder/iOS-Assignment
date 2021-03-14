//
//  SideMenuViewController.swift
//  DefineLabsAssignment
//
//  Created by Rishikesh Yadav on 3/13/21.
//

import UIKit


enum MenuList: Int {
    case All
    case selected
}

class SideMenuViewController: UITableViewController {
    var didTapMenuTyep: ((MenuList) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SideMenuViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuList(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuTyep?(menuType)
        }
        
    }
}
