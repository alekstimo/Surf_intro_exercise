//
//  TableViewCell.swift
//  surf_intro_project
//
//
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 12
        static let spaceBetweenRows: CGFloat = 12
        static let textSize: Int = 6
        static let cellHeight: CGFloat = 44
    }
    // MARK: - Properties
    private var arrayCollection: Array<String> = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var arr: Array<String> = []{
        didSet {
            arrayCollection = arr
        }
    }
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(vcDidScroll), name: NSNotification.Name("vcDidScroll"), object: nil)
        super.awakeFromNib()
        configure()
    }
    func configure() {
        selectionStyle = .none
        
        collectionView.register(UINib(nibName: "\(CarouselCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(CarouselCollectionViewCell.self)")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    // MARK: - NSNotification for synch scroll
    @objc func vcDidScroll(notification: NSNotification) {
        if let dict = notification.object
         as? NSDictionary{
            if let scrollView = dict["scrollView"] as? UICollectionView {
                guard scrollView !=  collectionView else { return }
                
                collectionView.contentOffset = scrollView.contentOffset
                
                }
                
            }
            
    }
        
    
}
// MARK: - UICollection
extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayCollection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CarouselCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? CarouselCollectionViewCell {
            cell.titleText = arrayCollection[indexPath.row]
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = CGFloat(arrayCollection[indexPath.row].count * Constants.textSize + 80 )
        return CGSize(width: itemWidth, height: Constants.cellHeight)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return Constants.spaceBetweenRows

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let collectionViewDictionary = ["scrollView": self.collectionView]
        NotificationCenter.default.post(name: NSNotification.Name("vcDidScroll"), object: collectionViewDictionary)
    }
   

}


