//
//  ApiError.swift
//  firsttimer
//
//  Created by Aral Atpulat on 5.04.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

enum ApiError: String, Error {
    case invalidURL =  "Error: The URL is invalid"
    case invalidRequest = "Error: Request is invalid"
    case invalidDecode = "Error: Response decode is invalid"
}
