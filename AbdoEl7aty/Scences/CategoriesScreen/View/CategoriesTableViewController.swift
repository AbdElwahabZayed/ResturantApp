//
//  CategoriesTableViewController.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

protocol CategoriesControllerToPresenter : AnyObject {
    func reloadTableData()
}

class CategoriesTableViewController: UITableViewController {

    
    var presenter : CategoriesPresenterToCategoriesController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CategoriesPresenter(view: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getResultCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = presenter?.getCategoriesAtIndexPath(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuItemsTableViewController") as! MenuItemsTableViewController
        let presenter = MenuItemPresenter(categoryName: self.presenter?.getCategoriesAtIndexPath(at: indexPath) ?? "",view: destVC)
        destVC.setPresenter(presenter: presenter)
        self.navigationController?.pushViewController(destVC, animated: true)
    }

}


extension CategoriesTableViewController : CategoriesControllerToPresenter{
    func reloadTableData() {
        self.tableView.reloadData()
    }
}
