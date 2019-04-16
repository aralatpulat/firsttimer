//
//  SearchViewModal.swift
//  firsttimer
//
//  Created by Aral Atpulat on 16.04.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import Foundation

class SearchViewModal {
    
    var issues: Search = Search()
    var pageCount: Int = 1
    let apiClient = ApiClient()
    var state: ((SearchState) -> ())?

    func getIssues(){
        let page = "\(pageCount)"
        apiClient.getIssues(page: page) { [weak self] (data) in
            self?.issues = data
            self?.state?(SearchState.updated)
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int){
        if currentIndex == issues.items.count - 1 {
            pageCount += 1
            apiClient.getIssues(page: "\(pageCount)") { [weak self] (data) in
                self?.issues.items.append(contentsOf: data.items)
                self?.state?(SearchState.updated)
            }
        }
    }
}
