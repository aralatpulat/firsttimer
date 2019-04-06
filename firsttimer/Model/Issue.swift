//
//  Issue.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

struct Issue: Codable {
    var id: Int
    var htmlUrl: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case htmlUrl = "html_url"
        case title
    }
}
