//
//  IssueCell.swift
//  firsttimer
//
//  Created by Aral Atpulat on 6.04.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(issue: Issue) {
        titleLabel.text = issue.title
    }    
}
