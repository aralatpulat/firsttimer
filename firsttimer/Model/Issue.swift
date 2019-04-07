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
    var repoUrl: String
    var title: String
    var number: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case htmlUrl = "html_url"
        case repoUrl = "repository_url"
        case title
        case number
    }
}

extension Issue {
    
    var repoName: String  {
        let splittedRepo = self.repoUrl.components(separatedBy: "/")
        return "\(splittedRepo[4])/\(splittedRepo[5])"
    }
    
    var numberWithSign: String {
        return "#\(self.number)"
    }
}
