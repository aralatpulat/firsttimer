//
//  ViewController.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import UIKit
import SafariServices

class IssuesViewController: UIViewController {

    @IBOutlet weak var issuesTableView: UITableView!
    
    var issues: Search = Search()
    var pageCount: Int = 1
    let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadData()
    }
    
    @objc private func reloadData(){
        let page: String = "\(pageCount)"
        apiClient.getIssues(page: page) { [weak self] (data) in
            self?.issues = data
            self?.issuesTableView.reloadData()
            self?.issuesTableView.refreshControl?.endRefreshing()
        }
    }
    
    private func setupTableView(){
        issuesTableView.register(UINib(nibName: "IssueCell", bundle: nil), forCellReuseIdentifier: "cellId")
        issuesTableView.delegate = self
        issuesTableView.dataSource = self
        
        let refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        issuesTableView.refreshControl = refreshCtrl
    }
    
    private func loadMoreIfNeeded(currentIndex: Int){
        if currentIndex == issues.items.count - 1 {
            pageCount += 1
            apiClient.getIssues(page: "\(pageCount)") { [weak self] (data) in
                self?.issues.items.append(contentsOf: data.items)
                self?.issuesTableView.reloadData()
                self?.issuesTableView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension IssuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        loadMoreIfNeeded(currentIndex: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! IssueCell
        cell.setup(issue: issues.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoHtmlUrl = URL(string: issues.items[indexPath.row].htmlUrl)
        
        if let url = repoHtmlUrl {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
       
    }
}

