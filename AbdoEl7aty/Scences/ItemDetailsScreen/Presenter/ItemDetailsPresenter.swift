//
//  ItemDetailsPresenter.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation

protocol ItemDetailsPresenterController {
    func getItem()->MenuItem
    
    func addItem()
}

class ItemDetailsPresenter: ItemDetailsPresenterController{
    
    private var item : MenuItem
    
    private weak var view: ItemDetailsViewControllerProtocols?
    
    private let menuControllerProtocol:MenuControllerProtocol
    
    init(item: MenuItem, view: ItemDetailsViewControllerProtocols, menuControllerProtocol: MenuControllerProtocol = MenuController.shared) {
        self.item = item
        self.view = view
        self.menuControllerProtocol = menuControllerProtocol
    }
    
    func getItem() -> MenuItem {
        return item
    }
    
    func addItem() {
        menuControllerProtocol.addItem(itemID: item)
    }
    
}
