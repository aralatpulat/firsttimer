//
//  Language.swift
//  firsttimer
//
//  Created by Aral Atpulat on 4.04.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

struct Language: Codable {
    var urlParam: String
    var name: String
}

struct Languages: Codable {
    var popular: [Language]
    var all: [Language]
}
