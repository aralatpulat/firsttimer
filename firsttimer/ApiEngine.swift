//
//  ApiEngine.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation
import Alamofire

class ApiEngine {
    
    typealias errorHandler = (Error) -> Void
    
    func get<T: Decodable>(from url: URL,
                           type: T.Type,
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping errorHandler) {
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                do{
                    let resObj = try JSONDecoder().decode(T.self, from: value)
                    successHandler(resObj)
                    return
                } catch{
                    errorHandler(ApiError.invalidDecode)
                    return
                }
            case .failure( _):
                errorHandler(ApiError.invalidRequest)
                return
            }
        }
    }
}
