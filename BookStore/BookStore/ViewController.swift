//
//  ViewController.swift
//  BookStore
//
//  Created by Seori on 2022/10/18.
//

import UIKit

final class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
    }
}

