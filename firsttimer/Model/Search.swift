//
//  Issues.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

struct Search: Codable {
    var totalCount: Int = 0
    var items: [Issue] = []
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
