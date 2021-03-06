//
//  PediaItemDetailViewController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 16/3/22.
//

import UIKit

class PediaItemDetailViewController: UIViewController {
    
    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var headerContent: UIView!
    
    lazy var cRPediaService: CRPediaService = CRPediaService()
    var element: PediaElement = PediaElement()
    
    init(_ element: PediaElement) {
        super.init(nibName: "PediaItemDetailView", bundle: nil)
        self.element = element
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetails()
        getPediaElement()
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func getPediaElement() {
        switch (self.element.type) {
            case .Monster: do {
                let monster = self.element
                cRPediaService.getMonsterById(id: monster.monsterCode?.idString ?? "") { element in
                    var monster = element
                    self.itemName.text = monster.name?.deleteStrangeCharacters()
                    self.itemDescription.text = "NO DESCRIPTION"
                    self.cRPediaService.getElementImage(iconId: String(Int(monster.iconId ?? 0))) { response in
                        self.itemImage.image = response
                    }
                }
            }
            case .Item: do {
                let item = self.element
                cRPediaService.getItemById(id: item.itemCode?.idString ?? "") { element in
                    var item = element
                    self.itemName.text = item.name?.deleteStrangeCharacters()
                    self.itemDescription.numberOfLines = item.itemInfo?.count ?? 1
                    var description = item.itemInfo?.reduce("") { result, info in
                        result + "\n" + info
                    }
                    self.itemDescription.text = description?.deleteStrangeCharacters()
                    self.itemDescription.sizeToFit()
                    self.cRPediaService.getElementImage(iconId: String(Int(item.iconId ?? 0))) { response in
                        self.itemImage.image = response
                    }
                }
            }
            case .Fixe: do {
                let fix = self.element
                cRPediaService.getFixById(id: fix.itemCode?.idString ?? "") { element in
                    var fix = element
                    self.itemName.text = fix.name?.deleteStrangeCharacters()
                    self.itemDescription.text = fix.itemInfo?.joined(separator: "\n")
                    self.cRPediaService.getElementImage(iconId: String(Int(fix.iconId ?? 0))) { response in
                        self.itemImage.image = response
                    }
                }
            }
        }
    }
    
    func setUpDetails() {
        itemName.font = UIFont(name: "Nunito Sans ExtraBold", size: 20)
        itemDescription.font = UIFont(name: "Nunito Sans", size: 16)
        itemDescription.textColor = UIColor.CRTextDescription()
        headerContent.backgroundColor = UIColor.CRPrimaryColor()
        itemImage.layer.borderWidth = 2
        itemImage.layer.borderColor = UIColor.white.cgColor
        itemImage.layer.cornerRadius = 7
        itemName.textColor = .black
    }
    
}

