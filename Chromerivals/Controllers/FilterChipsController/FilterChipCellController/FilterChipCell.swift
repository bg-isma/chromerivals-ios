//
//  FilterChipCell.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import UIKit

class FilterChipCell: UICollectionViewCell {
    
    @IBOutlet weak var filterChipContent: UIView!
    @IBOutlet weak var filterChipText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpChip()
    }
    
    func setUpChip() {
        filterChipContent.layer.borderWidth = 1
        filterChipContent.layer.cornerRadius = 16
        filterChipContent.layer.borderColor = UIColor.black.cgColor
    }
    
    func select() {
        filterChipContent.backgroundColor = .black
        filterChipText.textColor = .white
        filterChipContent.layer.borderColor = UIColor.black.cgColor
    }
    
    func unSelect() {
        filterChipContent.backgroundColor = .white
        filterChipText.textColor = .black
    }

}
