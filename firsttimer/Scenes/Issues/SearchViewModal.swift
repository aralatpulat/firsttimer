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
    var searchedText: String = ""
    var isPagingFinished: Bool = false
    let apiClient = ApiClient()
    var stateHandler: ((SearchState) -> ())?
    
    var state: SearchState! {
        didSet {
            self.stateHandler?(state)
        }
    }
    
    var page: String {
        return "\(pageCount)"
    }
    
    func getIssues(){
        self.state = SearchState.fetching
        
        apiClient.getIssues(page: page, search: searchedText) { [weak self] (data) in
            
            self?.issues = data
            self?.state = SearchState.searched            
            self?.isPagingFinished = self?.checkIfCountIsZero(data.items) ?? false
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int){
        if currentIndex == issues.items.count - 1 && !isPagingFinished {
            pageCount += 1
            
            if self.state == SearchState.fetching { return }
            
            self.state = SearchState.fetching
            apiClient.getIssues(page: page, search: searchedText) { [weak self] (data) in

                self?.issues.items.append(contentsOf: data.items)
                self?.state = SearchState.fetched
                self?.isPagingFinished = self?.checkIfCountIsZero(data.items) ?? false
            }
        }
    }
}

extension SearchViewModal {
    
    private func checkIfCountIsZero(_ items: [Issue]) -> Bool {
        return items.count == 0
    }
}
