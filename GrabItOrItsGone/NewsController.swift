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

class News:NSObject {
    var title:String?
    var message:String?
    /*var Image:UIImage?
    var URL:String?*/
}

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var NewsTableView: UITableView!
    
    //MARK: Members
    var facade:GrabItFacade?
    var newsArray:[News]?
    var refhandle:UInt!
    private var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsTableView.delegate = self
        NewsTableView.dataSource = self as UITableViewDataSource
        
        ref = Database.database().reference()
        
        facade = GrabItFacade(presentingController: self)
        newsArray = []
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReadFirebaseNewsSection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ReadFirebaseNewsSection() -> Void {
        // let userid = Auth.auth().currentUser!.uid as String
       refhandle = ref.child("news").observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String:AnyObject]{
                print(dict)
                let news = News()
                news.title = dict["title"] as? String
                news.message = dict["message"] as? String
                print(news.title!)
                print(news.message!)
                self.newsArray!.append(news)
                
                DispatchQueue.main.async {
                    self.NewsTableView.reloadData()
                }
            }
       })
    }
    
    //MARK: - Tableview Setup
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray!.count
    }
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.ConfigureCell(title: newsArray![indexPath.row].title!, message: newsArray![indexPath.row].message!)
        return cell
    }
}
