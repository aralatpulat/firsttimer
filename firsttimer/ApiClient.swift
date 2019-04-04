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
        let url = UrlBuilder.languages()
        apiEngine.get(from: url!, type: Languages.self) { value in
            print(value)
        }
    }
    
    func getIssues(completion: @escaping (Search) -> ()) {
        let items = [
            URLQueryItem(name: "q", value: "+language:swift+type:issue+is:open"),
            URLQueryItem(name: "page", value: "1")
        ]
        let url = UrlBuilder.issues(queryItems: items)
        apiEngine.get(from: url!, type: Search.self) { value in
            print(value)
            completion(value)
        }
    }
}
