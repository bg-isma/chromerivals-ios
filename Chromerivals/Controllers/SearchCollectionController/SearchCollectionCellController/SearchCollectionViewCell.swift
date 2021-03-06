//
//  SearchCollectionViewCell.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pediaItemName: UILabel!
    @IBOutlet weak var pediaItemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    func setUpCellContent(pediaElement: PediaElement) {
        var element = pediaElement
        pediaItemName.text = element.name?.deleteStrangeCharacters() ?? ""
        CRPediaService().getElementImage(iconId: String(Int(element.iconId ?? 0)), { response in
            self.pediaItemImage.image = response
        })
    }
    
    func setUpCell() {
        pediaItemImage.makeRounded()
        pediaItemName.font = UIFont(name: "Nunito Sans", size: 13)
        pediaItemName.textColor = UIColor.CRPrimaryColor()
    }

}
