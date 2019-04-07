//
//  ViewController.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import UIKit

class IssuesViewController: UIViewController {

    @IBOutlet weak var issuesTableView: UITableView!
    
    var issues: Search = Search()
    let apiClient = ApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        reloadData()
    }
    
    @objc private func reloadData(){
        apiClient.getIssues() { [weak self] (data) in
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
}

extension IssuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! IssueCell
        cell.setup(issue: issues.items[indexPath.row])
        return cell
    }
}

