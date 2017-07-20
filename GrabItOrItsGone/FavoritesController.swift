//
//  ManageFavoritesController.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource, IFirebaseWebService {
    //MARK:- Outlets
    @IBOutlet var BackgroundImange: UIImageView!
    @IBOutlet var BackgroundImageBlurrView: UIVisualEffectView!
    @IBOutlet var FavoritesTableView: UITableView!
    
    //MARK:- Members
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var facade:FavoritesFacade!
    var selectedProduct:ProductCard!
    
    //MARK:- Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facade = FavoritesFacade()
        facade.firebaseClient.delegate = self
        self.navigationItem.title = .ManageFavoritesController_TitleString
        appDel.productsArray = []
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
        if facade.favoritesArray.count > 0{
            cell.ConfigureCell(product: facade.favoritesArray[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = facade.favoritesArray[indexPath.row]
        performSegue(withIdentifier: String.SegueToFavoritesDetailController_Identifier, sender: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            facade.DeleteFavoriteWithID(idToDelete: facade.favoritesArray[indexPath.row].ID!)
            facade.favoritesArray.remove(at: indexPath.row)
        }
    }
    
    
    //MARK:- IFirebaseDataReceivedDelegate implementation
    func FirebaseRequestFinished() {
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
