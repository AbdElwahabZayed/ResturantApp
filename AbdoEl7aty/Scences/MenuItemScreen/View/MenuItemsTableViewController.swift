//
//  MenuItemsTableViewController.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

protocol MenuItemsControllerProtocols :AnyObject{
    func reloadTableData()
    func setPresenter(presenter:MenuItemsPreseterProtocols)
}

class MenuItemsTableViewController: UITableViewController {

    
    private var presenter : MenuItemsPreseterProtocols?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getMenuItemsCount() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as! MenuItemTableViewCell
        
        let menuItem = self.presenter?.getMenuitemAtIndex(indexPath: indexPath.row)!
        
        cell.itemNameLabel.text = menuItem?.name
        //print(cell.itemNameLabel.text)
        //cell.itemImage = UIImage(named: menuItem?.imageURL)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        if let i = self.presenter?.getMenuitemAtIndex(indexPath: indexPath.row) {
            let presenter = ItemDetailsPresenter( item: i, view: destVC)
            destVC.setPresenter(presenter: presenter)
            self.navigationController?.pushViewController(destVC, animated: true)
        }
        
    }
    
    func setPresenter(presenter:MenuItemsPreseterProtocols){
        self.presenter=presenter
    }

}

extension MenuItemsTableViewController:MenuItemsControllerProtocols{
    func reloadTableData() {
        self.tableView.reloadData()
    }
}
