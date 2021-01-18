//
//  OrdersItemsTableViewCell.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class OrdersItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var variation1: UILabel!
    @IBOutlet weak var variation2: UILabel!
    @IBOutlet weak var variation3: UILabel!
    @IBOutlet weak var variationPrice1: UILabel!
    @IBOutlet weak var variationPrice2: UILabel!
    @IBOutlet weak var variationPrice3: UILabel!
    
    func loadUI(item: OrderItem){
        
        containerView.setupShadow()
        containerView.layer.cornerRadius = 15
        logo.layer.cornerRadius = logo.frame.height/2
        quantityValue.text = "\(item.count)"
        
        itemName.text = item.itemName
        logo.sd_setImage(with: URL(string: item.restaurantImage))
        
        if let _ = item.firstAttrItemsBody, let _ = item.firstAttrItemsNameEn, let _ = item.firstAttrItemsNameAr{
            variation1.isHidden = false
            variationPrice1.isHidden = false
            if "lang".localized == "ar"{
                variation1.text = item.firstAttrItemsNameAr! + " : " + (item.firstAttrItemsBody?.nameAr)!
            }else{
                variation1.text = item.firstAttrItemsNameEn! + " : " + (item.firstAttrItemsBody?.nameEn)!
            }
            variationPrice1.text = item.firstAttrItemsBody!.price + " " + "KWD".localized
        }
        
        if let _ = item.secondAttrItemsBody, let _ = item.secondAttrItemsNameAr, let _ = item.secondAttrItemsNameEn{
            variation2.isHidden = false
            variationPrice2.isHidden = false
            if "lang".localized == "ar"{
                variation2.text = item.secondAttrItemsNameAr! + " : " + (item.secondAttrItemsBody?.nameAr)!
            }else{
                variation2.text = item.secondAttrItemsNameEn! + " : " + (item.secondAttrItemsBody?.nameEn)!
            }
            variationPrice2.text = item.secondAttrItemsBody!.price + " " + "KWD".localized
        }
        
        if let _ = item.thirdAttrItemsBody, let _ = item.thirdAttrItemsNameAr, let _ = item.thirdAttrItemsNameEn{
            variation3.isHidden = false
            variationPrice3.isHidden = false
            if "lang".localized == "ar"{
                variation3.text = item.thirdAttrItemsNameAr! + " : " + (item.thirdAttrItemsBody?.nameAr)!
            }else{
                variation3.text = item.thirdAttrItemsNameEn! + " : " + (item.thirdAttrItemsBody?.nameEn)!
            }
            variationPrice3.text = item.thirdAttrItemsBody!.price + " " + "KWD".localized
        }
        
        
    }
    
}
