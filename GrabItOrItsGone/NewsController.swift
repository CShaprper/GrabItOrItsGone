//
//  NewsController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
struct News {
    var Title:String
    var Message:String
    var Image:UIImage
    var URL:String
    init(title: String, message: String, image: UIImage, url: String) {
        Title = title
        Message = message
        Image = image
        URL = url
    }
}

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var NewsTableView: UITableView!
    
    //MARK: - Members
    var NewsArray:[News]!

    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.delegate = self
        NewsTableView.dataSource = self as! UITableViewDataSource
        
        NewsArray = [News]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Tableview Setup
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsArray.count
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
