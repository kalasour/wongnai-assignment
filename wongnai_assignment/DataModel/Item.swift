//
//  item.swift
//  wongnai_assignment_1
//
//  Created by Nuntawat. Wisedsup on 6/11/2562 BE.
//  Copyright © 2562 Nuntawat. Wisedsup. All rights reserved.
//

import Foundation

struct Item: Codable {
    let current_page: Int?
    let total_pages: Int?
    let total_items: Int?
    let feature: String?
    let filters: Filter?
    let photos: [Photo]?
    
    
}
