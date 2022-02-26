//
//  Networking.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation

protocol MenuControllerProtocol {
    
    typealias MinuteToPrepare = Int
    
     func fetchCategories(completion: @escaping (Result<CategoriesResponse,Error>)->Void)
    
     func fetchMenuItems(forCategory categoryName:String,completion:@escaping (Result<MenuResponse,Error>)->Void)
    
     func submitOrder(forMenuIDs menuIDs:[Int],completion:@escaping (Result<OrderResponse,Error>)->Void)
    
    func addItem(itemID:MenuItem)
    
    func getItems()->[MenuItem]
    
    func removeItems(index:Int)
    
    func getOrderUpdateNotification() -> NSNotification.Name
}


class MenuController: MenuControllerProtocol{
    
    
    static let orderUpdatedNotification =
       Notification.Name("MenuController.orderUpdated")
    static var orderItemsIds:Order = Order(){
        didSet {
            NotificationCenter.default.post(name:
                orderUpdatedNotification, object: nil)
        }
    }
    
    static var shared = MenuController()
    
    private let baseURL=URL(string: "http://localhost:8080/")!
    
    
    private init(){
        
    }
    
     func fetchCategories(completion: @escaping (Result<CategoriesResponse,Error>)->Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL){
            (data,response,error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let categoriesResponse = try
                        jsonDecoder.decode(CategoriesResponse.self,
                                           from: data)
                    completion(.success(categoriesResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
     func fetchMenuItems(forCategory categoryName:String,completion:@escaping (Result<MenuResponse,Error>)->Void){
        let orderURL=baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: orderURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        // fetchMenuItems
        let task = URLSession.shared.dataTask(with: menuURL)
           { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let menuResponse = try
                       jsonDecoder.decode(MenuResponse.self, from: data)
                    completion(.success(menuResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
     func submitOrder(forMenuIDs menuIDs:[Int],completion:@escaping (Result<OrderResponse,Error>)->Void){
        let orderURL=baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        let data = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
  // submitOrder
        let task = URLSession.shared.dataTask(with: request)
           { (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try
                       jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func addItem(itemID:MenuItem){
        MenuController.orderItemsIds.items.append(itemID)
    }
    func getItems()->[MenuItem]{
        return  MenuController.orderItemsIds.items
    }
    func removeItems(index:Int) {
        MenuController.orderItemsIds.items.remove(at: index)
    }
    
    func getOrderUpdateNotification()-> NSNotification.Name{
        return MenuController.orderUpdatedNotification
    }
}
