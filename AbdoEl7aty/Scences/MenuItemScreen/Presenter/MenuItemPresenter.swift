//
//  MenuItemPresenter.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation
protocol MenuItemsPreseterProtocols {
    func loadMenuItems()
    func getMenuItemsCount() -> Int
    func getMenuitemAtIndex(indexPath : Int)-> MenuItem?
}

class MenuItemPresenter: MenuItemsPreseterProtocols{
    
    
    private var categoryName: String
    private var menuItems : [MenuItem]?
    private var menuController : MenuControllerProtocol
    private weak var view : MenuItemsControllerProtocols?
    
    init(categoryName: String,view : MenuItemsControllerProtocols,menuController: MenuControllerProtocol = MenuController.shared) {
        self.categoryName = categoryName
        self.view = view
        self.menuController = menuController
        loadMenuItems()
    }

    func loadMenuItems() {
        menuController.fetchMenuItems(forCategory: categoryName) { [weak self] (result: Result<MenuResponse, Error>) in
            switch result {
            case .success(let response):
                self?.menuItems = response.items
                print(self?.categoryName)
                DispatchQueue.main.async {
                    self?.view?.reloadTableData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getMenuItemsCount() -> Int {
        return menuItems?.count ?? 0
    }
    
    func getMenuitemAtIndex(indexPath : Int) -> MenuItem?{
        return menuItems?[indexPath]
        
    }
}
