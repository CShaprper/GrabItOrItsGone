//
//  ManageFavoritesController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class ManageFavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource, IFirebaseDataReceivedDelegate {
    //MARK:- Outlets
    @IBOutlet var BackgroundImange: UIImageView!
    @IBOutlet var BackgroundImageBlurrView: UIVisualEffectView!
    @IBOutlet var FavoritesTableView: UITableView!
    
    //MARK:- Members
    var facade:ManageFavoritesFacade!
    var selectedProduct:ProductCard!
    
    //MARK:- Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facade = ManageFavoritesFacade()
        facade.firebaseClient.firebaseDataReceivedDelegate = self
        self.navigationItem.title = .ManageFavoritesController_TitleString
        facade.ReadFirebaseFavoritesSection()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return facade.favoritesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.FavoritesTableViewCell_Identifier, for: indexPath) as! FavoritesTableViewCell
        cell.ConfigureCell(product: facade.favoritesArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = facade.favoritesArray[indexPath.row]
        performSegue(withIdentifier: String.SegueToFavoritesDetailController_Identifier, sender: nil)
    }
    
    
    //MARK:- IFirebaseDataReceivedDelegate implementation
    func FirebaseDataReceived() {
        facade.favoritesArray = facade.firebaseClient.favoritesArray
        FavoritesTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String.SegueToFavoritesDetailController_Identifier{
            if let destination = segue.destination as? FavoritesDetailController{
                if selectedProduct != nil{
                   destination.selectedProduct = selectedProduct
                }
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
