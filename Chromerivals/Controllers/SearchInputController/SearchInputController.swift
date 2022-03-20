//
//  SearchInputController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 18/3/22.
//

import UIKit

class SearchInputController: UIViewController, UITextFieldDelegate, CRViewComponent {

    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var searchInputContent: UIView!
    
    lazy var collectionViewController: SearchCollectionController? = nil
    lazy var contentSize: CGSize = CGSize(width: 0, height: 75)
    lazy var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
    
    init(_ controller: SearchCollectionController) {
        super.init(nibName: "SearchInputView", bundle: nil)
        self.collectionViewController = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchInput()
        self.view.frame.size.height = contentSize.height + insets.top + insets.bottom
        self.view.frame = self.view.frame.inset(by: insets)
    }
    
    func setUpSearchInput() {
        searchInput.toChromerivalsTextField()
        searchInputContent.layer.cornerRadius = 40
        searchInputContent.backgroundColor = UIColor.CRGrayColor()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.collectionViewController?.searchItems(query: textField.text ?? "")
        self.view.endEditing(true)
        return true
     }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchInput.text = ""
        self.view.endEditing(true)
        return true
    }
    
}
