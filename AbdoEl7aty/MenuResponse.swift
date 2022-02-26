//
//  Categories.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation

// MARK: - Categories
struct MenuResponse: Codable {
    let items: [MenuItem]
}

// MARK: - Item
struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}
