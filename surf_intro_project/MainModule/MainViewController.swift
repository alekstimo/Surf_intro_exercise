//
//  MainViewController.swift
//  surf_intro_project
//
//
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Properties
    
    var arrayColection = ["IOS","Android","Design","Flutter","QA","PM"]
    var arraySecondCollection = ["Честность","Ответственность","Пунктуальность","Гибкость","Усидчивость","Обучаемость","Инициативность","Дружелюбие","Педантичность ","Исполнительность"]
    
    var arrayToTableView_1: Array<String> = []
    var arrayToTableView_2: Array<String> = []
    var currentIndex = IndexPath()
    
    // MARK: - Constants
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 12
        static let spaceBetweenRows: CGFloat = 12
        static let textSize: Int = 6
    }
    //MARK: View
    
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var itemsView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        NotificationCenter.default.addObserver(self, selector: #selector(cangeSelect), name: NSNotification.Name("cangeSelect"), object: nil)
    }
    //MARK: Send function
    @IBAction func mailButtonPushed(_ sender: Any) {
        let alert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureApperance() {
        
        itemsView.layer.cornerRadius = 32
        itemsView.frame.size.height = self.view.frame.height
        
        mailButton.layer.cornerRadius = 32
        mailButton.clipsToBounds = true
        mailButton.setTitle("Отправить заявку", for: .normal)
        mailButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        questionLabel.text = "Хочешь к нам?"
        questionLabel.font = .systemFont(ofSize: 14)
        questionLabel.textColor = UIColor(named: "TextColor")
        
        
        titleLabel.text = "Стажировка в Surf"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(named: "Selected")
        
        descriptionLabel.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        descriptionLabel.textColor = UIColor(named: "TextColor")
        descriptionLabel.font = .systemFont(ofSize: 14)
        
        secondDescriptionLabel.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        secondDescriptionLabel.textColor = UIColor(named: "TextColor")
        secondDescriptionLabel.font = .systemFont(ofSize: 14)
        
        collectionView.register(UINib(nibName: "\(CarouselCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(CarouselCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 12)
        

   
        //TODO: table view с 2 collection view? для выравнивания по левому краю

        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "\(TableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(TableViewCell.self)")
       
        
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        divadeArray()

    }
    private func divadeArray() {
        for i in 0...arraySecondCollection.count / 2 - 1 {
            arrayToTableView_1.append(arraySecondCollection[i])
        }
        for i in (arraySecondCollection.count / 2)...arraySecondCollection.count - 1 {
            arrayToTableView_2.append(arraySecondCollection[i])
        }
    }
    //MARK: Scroll up-down view recognizer
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
      if let view = recognizer.view {
          
          if view.frame.minY + translation.y > 45 && view.frame.minY + translation.y < self.view.frame.maxY * 0.63 {
              view.center = CGPoint(x:view.center.x ,
                                    y:view.center.y + translation.y)
          }
      }
        recognizer.setTranslation(CGPointZero, in: self.view)
    }
    
    //MARK: swap collection elements
    @objc func cangeSelect(notification: NSNotification) {
        if let dict = notification.object
         as? NSDictionary{
            if let elem = dict["elem"] as? String{
                if let index = arrayColection.firstIndex(where:  {$0 == elem}) {
                   let ptrElem = arrayColection[index]
                    arrayColection.remove(at: index)
                    arrayColection.insert(ptrElem, at: 0)
                    collectionView.moveItem(at: IndexPath(indexes: [0,index]), to: IndexPath(indexes: [0,0]))
                }
                
            }
            
        }
        
    }

}



// MARK: - UICollection
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayColection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CarouselCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? CarouselCollectionViewCell {
            cell.titleText = arrayColection[indexPath.row]
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = CGFloat(arrayColection[indexPath.row].count * Constants.textSize + 66 )
        return CGSize(width: itemWidth, height: CGFloat(44))
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.spaceBetweenElements
        
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return Constants.spaceBetweenElements
//
//    }
    

}


// MARK: - UITable
extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)")
            if let cell = cell as? TableViewCell {
                cell.arr = arrayToTableView_1
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableViewCell.self)")
            if let cell = cell as? TableViewCell {
                cell.arr = arrayToTableView_2
                
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
   

}

