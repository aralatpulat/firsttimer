//
//  ViewController.swift
//  firsttimer
//
//  Created by Aral Atpulat on 26.03.2019.
//  Copyright © 2019 Aral Atpulat. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let engine = ApiEngine()
        let items = [
            URLQueryItem(name: "q", value: "+language:swift+type:issue+is:open"),
            URLQueryItem(name: "page", value: "1")
        ]
        let url = UrlBuilder.issues(queryItems: items)
        engine.get(from: url!, type: Search.self) { value in
            print(value)       
        }
    }
}

