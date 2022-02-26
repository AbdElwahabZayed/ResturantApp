//
//  OrderPresenter.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation



protocol OrderPresenterProtocol {
    func submitOrder()
    func getOrders()->[MenuItem]
    func getOrdersCount()->Int
    func removeItem(index:Int)
}

class OrderPresenter: OrderPresenterProtocol{
    
    private weak var view: OrderTableViewControllerProtocol?
   
    var menuControllerProtocol: MenuControllerProtocol
    
    init(view: OrderTableViewControllerProtocol, menuControllerProtocol: MenuControllerProtocol = MenuController.shared){
        self.view = view
        self.menuControllerProtocol = menuControllerProtocol
        
    }
    
    func submitOrder() {
        menuControllerProtocol.submitOrder(forMenuIDs: menuControllerProtocol.getItems().map{$0.id}) { [weak self] (result: Result<OrderResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.view?.showAlert(preperation: response.preparationTime)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getOrders() -> [MenuItem] {
        return menuControllerProtocol.getItems()
        
    }
    
    func getOrdersCount() -> Int {
        return menuControllerProtocol.getItems().count
    }
    func removeItem(index:Int){
        menuControllerProtocol.removeItems(index: index)

    }
    
}
    

