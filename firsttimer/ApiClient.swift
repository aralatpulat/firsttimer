//
//  ApiClient.swift
//  firsttimer
//
//  Created by Aral Atpulat on 31.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

class ApiClient {
    
    let apiEngine: ApiEngine
    
    init() {
        self.apiEngine = ApiEngine()
    }
    
    func getLanguages() {
        guard let url = UrlBuilder.languages() else {
            print(ApiError.invalidURL)
            return
        }
        apiEngine.get(
            from: url,
            type: Languages.self,
            successHandler: { value in
                print(value)
            },
            errorHandler: { error in
                print(error)
            }
        )
    }
    
    func getIssues(page: String, completion: @escaping (Search) -> ()) {
        let items = [
            URLQueryItem(name: "q", value: "+language:swift+type:issue+is:open"),
            URLQueryItem(name: "page", value: page)
        ]
        guard let url = UrlBuilder.issues(queryItems: items) else {
            print(ApiError.invalidURL)
            return
        }
        apiEngine.get(
            from: url,
            type: Search.self,
            successHandler: { value in
                print(value)
                completion(value)
            },
            errorHandler: { error in
                print(error)
            } 
        )
    }
}
