//
//  ViewController.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import UIKit
import SafariServices

public enum SearchState {
    case searched
    case fetching
    case fetched
}

class IssuesViewController: UIViewController {
    
    @IBOutlet weak var issuesTableView: UITableView!
    
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    let searchVM = SearchViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchCont()
        loadData()
        bindViewModal()
    }
    
    private func setupTableView(){
        issuesTableView.register(UINib(nibName: "IssueCell", bundle: nil), forCellReuseIdentifier: "cellId")
        issuesTableView.delegate = self
        issuesTableView.dataSource = self
    }
    
    private func setupSearchCont(){
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Issue"
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.hidesNavigationBarDuringPresentation = true
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            self.issuesTableView.tableHeaderView = searchController.searchBar
        }
    }
    
    @objc private func loadData(){
        searchVM.getIssues()
    }
    
    private func reloadTableData(){
        self.issuesTableView.reloadData()
    }
    
    
    private func bindViewModal(){
        searchVM.stateHandler = { [weak self] state in
            switch state {
            case .searched:
                self?.removeLoading()
                self?.reloadTableData()
                if self?.issuesTableView.numberOfRows(inSection: 0) != 0 {
                    self?.issuesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            case .fetching:
                self?.setLoading()
            case .fetched:
                self?.removeLoading()
                self?.reloadTableData()
            }
        }
    }
}

extension IssuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.issues.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        searchVM.loadMoreIfNeeded(currentIndex: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! IssueCell
        cell.setup(issue: searchVM.issues.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoHtmlUrl = URL(string: searchVM.issues.items[indexPath.row].htmlUrl)
        
        if let url = repoHtmlUrl {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

extension IssuesViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedText = searchBar.text else { return }
        searchVM.searchedText = searchedText
        searchVM.pageCount = 1
        searchVM.getIssues()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchVM.searchedText = ""
    }
}



