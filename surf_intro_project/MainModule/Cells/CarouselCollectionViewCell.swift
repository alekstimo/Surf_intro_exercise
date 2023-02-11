//
//  CarouselCollectionViewCell.swift
//  surf_intro_project
//
//
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    //MARK: Properties
    var isSelect: Bool = false
    @IBOutlet weak var categoryButton: UIButton!
    var titleText: String = "" {
        didSet {
            categoryButton.setTitle(titleText, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryButton.layer.cornerRadius = 12
        categoryButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    //MARK: select category function
    @IBAction func categoryButtonPushed(_ sender: Any) {
        isSelect = !isSelect
        if isSelect {
            categoryButton.tintColor = UIColor(named: "NotSelected")
            categoryButton.backgroundColor = UIColor(named: "Selected")
            NotificationCenter.default.post(name: NSNotification.Name("cangeSelect"), object: ["elem": titleText])
        } else {
            categoryButton.tintColor = UIColor(named: "Selected")
            categoryButton.backgroundColor = UIColor(named: "NotSelected")
        }
    }
}
