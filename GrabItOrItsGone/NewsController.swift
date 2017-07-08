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
    var Title:String?
    var Message:String?
    var Image:UIImage?
    var URL:String?
    init(title: String, message: String, image: UIImage, url: String) {
        Title = title
        Message = message
        Image = image
        URL = url
    }
    override init(){}
}

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Outlets
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var NewsTableView: UITableView!
    
    //MARK: Members
    var facade:GrabItFacade?
    var newsArray:[News]?
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
        ref.child("news").child("messages").observe(.value, with: { (snapshot) in
            let dict = snapshot.value as? [String:AnyObject]
            print(dict)
            DispatchQueue.main.async {
                let news = News()
                //print(snapshot.value(forKey: "users"))
                news.Title  = dict!["title"] as! String
                news.Message = dict!["message"] as! String
                self.newsArray!.append(news)
                self.NewsTableView.reloadData()
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
        cell.ConfigureCell(title: newsArray![indexPath.row].Title!, message: newsArray![indexPath.row].Message!)
        return cell
    }
}
