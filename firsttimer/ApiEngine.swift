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
    
    func get<T: Decodable>(from url: URL,
                           type: T.Type,
                           completion: @escaping (T) -> Void ){
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                do{
                    let resObj = try JSONDecoder().decode(T.self, from: value)
                    completion(resObj)
                } catch{
                    return
                }
            case .failure( _):
                return
            }
        }
    }
}
