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

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource, IFirebaseDataReceivedDelegate {
    //MARK:- Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var NewsTableView: UITableView!
    
    //MARK: Members
    var facade:NewsControllerFacade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup Views 
        SetUpViews()
        
        //Init facade
        facade = NewsControllerFacade(presentingController: self)
        facade!.firebaseDataReceivedDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = .NewsController_TitleString
        facade!.firebaseClient.ReadFirebaseNewsSection()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - IFirebaseDataReceivedDelegate implementation
    func FirebaseDataReceived() { 
        self.NewsTableView.reloadData()
    }
    
    
    //MARK: - Tableview Setup
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facade!.newsArray.count
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .NewsTableViewCell_Identifier) as! NewsTableViewCell 
        cell.ConfigureCell(title: facade!.newsArray![indexPath.row].title!, message: facade!.newsArray![indexPath.row].message!, date: facade!.newsArray[indexPath.row].date!)
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
