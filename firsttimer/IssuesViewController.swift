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
    case updated
}

class IssuesViewController: UIViewController {
    
    @IBOutlet weak var issuesTableView: UITableView!

    let searchVM = SearchViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        bindViewModal()
    }
    
    private func setupTableView(){
        issuesTableView.register(UINib(nibName: "IssueCell", bundle: nil), forCellReuseIdentifier: "cellId")
        issuesTableView.delegate = self
        issuesTableView.dataSource = self
        
        let refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        issuesTableView.refreshControl = refreshCtrl
    }
    
    @objc private func loadData(){
        searchVM.getIssues()
    }
    
    private func reloadTableData(){
        self.issuesTableView.reloadData()
        self.issuesTableView.refreshControl?.endRefreshing()
    }
    
    
    private func bindViewModal(){
        searchVM.state = { [weak self] state in
            switch state {
            case .updated:
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

