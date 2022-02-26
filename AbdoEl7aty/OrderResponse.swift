//
//  OrderResponse.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import Foundation

struct OrderResponse: Codable {
    let preparationTime: Int

    enum CodingKeys: String, CodingKey {
        case preparationTime = "preparation_time"
    }
}

struct Order {
    var items:[MenuItem] = [] 
}
