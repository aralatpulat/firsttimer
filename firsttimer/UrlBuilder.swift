//
//  UrlBuilder.swift
//  firsttimer
//
//  Created by Aral Atpulat on 31.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

enum BaseURL {
    case github
    case alternative
    
    func getBaseUrl() -> URLComponents {
        switch  self {
        case .github:
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            return components
        case .alternative:
            var components = URLComponents()
            components.scheme = "https"
            components.host = "github-trending-api.now.sh"
            return components
        }
    }
}

struct UrlBuilder {
    
    static func languages() -> URL? {
        var components = BaseURL.alternative.getBaseUrl()
        components.path = "/languages"
        return components.url
    }
    
    static func issues(queryItems: [URLQueryItem]) -> URL? {
        var components = BaseURL.github.getBaseUrl()
        components.path = "/search/issues"
        components.queryItems = queryItems
        return components.url
    }
}

