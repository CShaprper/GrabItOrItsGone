//
//  NewsController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 07.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource, IFirebaseWebService {
    //MARK:- Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var NewsTableView: UITableView!
    
    //MARK: Members
    var facade:NewsControllerFacade!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Views
        SetUpViews()
        
        //Init facade
        facade = NewsControllerFacade(presentingController: self)
        facade.firebaseClient.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = String.NewsController_TitleString
        facade.firebaseClient.ReadFirebaseNewsSection()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - IFirebaseWebService implementation
    func FirebaseRequestFinished() {
        self.NewsTableView.reloadData()
    }
    
    
    //MARK: - Tableview Setup
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facade!.newsArray.count
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.NewsTableViewCell_Identifier) as! NewsTableViewCell
        if facade.newsArray.count > 0 {
            let title = facade.newsArray[indexPath.row].title != nil ? facade.newsArray[indexPath.row].title! : ""
            let message = facade.newsArray[indexPath.row].message != nil ? facade.newsArray[indexPath.row].message! : ""
            let date = facade.newsArray[indexPath.row].date != nil ? facade.newsArray[indexPath.row].date! : ""
            cell.ConfigureCell(title: title, message: message , date: date)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = UITableViewAutomaticDimension
        return view.frame.size.height * 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    //MARK: - Setup Views
    func SetUpViews() -> Void {
        NewsTableView.delegate = self
        NewsTableView.dataSource = self as UITableViewDataSource
    }
}
