//
//  ProductCards.swift
//  GrabIt
//
//  Created by Peter Sypek on 26.06.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class ProductCard {
    var ID:String?
    var ProductCategory:String?
    var AddedToFavorites: Date?
    var Title:String?
    var Subtitle:String?
    var OriginalPrice:Double?
    var NewPrice:Double?
    var ProdcutImage:UIImage?
    var Productinformation:String?
    var ImageURL:String?
    
    init() {
        
    }
    
    init(productCategory:String, imageURL:String, title:String, subtitle:String, originalprice:Double, newprice:Double, image:UIImage, information:String) {
        ProductCategory = productCategory
        ImageURL = imageURL
        Title = title
        Subtitle = subtitle
        OriginalPrice = originalprice
        NewPrice = newprice
        ProdcutImage = image
        Productinformation = information
    }
    
    
   /* func CreateDummyProducts() -> [ProductCard]{
        var products:[ProductCard] = []
        let prod1 = ProductCard(productCategory: eProductCategory.Electronic.rawValue,  imageURL: "Product-Electronic.png", title: "Special Phone 4G", subtitle: "Brand new Design 128GB", originalprice: 699, newprice: 599, image: #imageLiteral(resourceName: "Product-Electronic"), information: "Das ist ein Informationstext zu einem Special Phone 4G.                                                  Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
        products.append(prod1)
        
        let prod2 = ProductCard(productCategory: eProductCategory.Cosmetics.rawValue,  imageURL: "Product_Cream.png",title: "Sun Screener Extra", subtitle: "Neue Formel - Bester Schutz", originalprice: 29.99, newprice: 19.99, image: #imageLiteral(resourceName: "Product_Cream"), information: "Das ist ein Informationstext zu Sun Screener Extra.                                                                       Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
        products.append(prod2)
        
        let prod3 = ProductCard(productCategory: eProductCategory.Cosmetics.rawValue,  imageURL: "Product_Cream2.png",title: "Splash Cream", subtitle: "Hautpflege vom Feinsten", originalprice: 39.99, newprice: 29.99, image: #imageLiteral(resourceName: "Product_Cream2"), information: "Das ist ein Informationstext zu Splash Cream.                                                                                  Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
        products.append(prod3)
        
        let prod4 = ProductCard(productCategory: eProductCategory.Jewelry.rawValue,  imageURL: "Product_Jewelry.png",title: "Eternity Ring", subtitle: "Sagen Sie es mit Gold", originalprice: 1339.99, newprice: 1129.99, image: #imageLiteral(resourceName: "Product_Jewelry"), information: "Das ist ein Informationstext zu Eternity Ring.                                                                                                                                    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
        products.append(prod4)
        
        let prod5 = ProductCard(productCategory: eProductCategory.Jewelry.rawValue,  imageURL: "Product_Jewelry3.png",title: "Eternity Armreif", subtitle: "Sagen Sie es mit Gold", originalprice: 399.00, newprice: 199.00, image: #imageLiteral(resourceName: "Product_Jewelry2"), information: "Das ist ein Informationstext zu Eternity Ring.                                                                                                                                    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")
        products.append(prod5)
        
        
        return products
    }*/
}
