//
//  BookDateController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/2.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
/// table: UITableViewDelegate,UITableViewDataSource
class BookDateController: UIViewController, UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate{
  
    

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblPubdate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var angTitle: UINavigationItem!
    @IBOutlet var itemCollection: UIBarButtonItem!
    @IBOutlet var textAuthor: UITextView!
    @IBOutlet var textSummary: UITextView!
    
    let factory = BookFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    let factorys = CategotyFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    var book:VMBook?
    var category:VMCategoty?
    var star = "star_no"
    var readonly = false
    var categorys:[VMCategoty]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorys = try? factorys.getAllCategories()
        Alamofire.request(book!.image!).responseImage{ response in
            if let imag = response.result.value {
                self.imgCover.image = imag
            }
        }
        self.lblUserName.text = book!.author
        self.lblPublisher.text = book!.publisher
        self.lblPubdate.text = book!.pubdate
        self.lblPrice.text = book!.price
        self.textAuthor.text = book!.authorIntro
        self.textSummary.text = book!.summary
        angTitle.title = book!.title
        if (try? factory.isBookExists(book: book!)) ?? false{
            star = "star_yes"
        }
        itemCollection.image = UIImage(named: star)
        
        itemCollection.isEnabled = !readonly
    }
    @IBAction func completeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func collectionAction(_ sender: Any) {
        let exists = (try? factory.isBookExists(book: book!)) ?? false
        if exists {
            let (success, error) = try! factory.removeBook(book: book!)
            if success {
                 itemCollection.image = UIImage(named: "star_no")
            } else {
                UIAlertController.showAlert(error!, in: self)
            }
        } else {
            if category != nil {
                
                book!.categoryId = category!.id
                let (success, _) =  factory.addBook(book: book!)
                if success{
                     itemCollection.image = UIImage(named: "star_yes")
                }
            } else{
                
//                let picker = ActionViewPicker<VMCategoty>(handeler: self, title: "选择图书类别", items: categorys!, mother: self.view)
//                picker.show()
                /// tableview
//                picker = ActionTablePicker(title: "选择图书类别", count: categorys!.count, dataSource: self , delegate: self).show(superView: self.view)
                pickerOfCollection = ActionCollectionPicker(title: "选择图书类别", count: categorys!.count, dataSource: self, delegate: self, reusdId: actionCellReuseId).show(superView: self.view)
            }
        }
    }
    
     private var picker:ActionTablePicker?
    private var pickerOfCollection:ActionCollectionPicker?
    func itemSelectde(index: Int) {
        let category = categorys![index]
        book?.categoryId = category.id
        let (success, _) =  factory.addBook(book: book!)
        if success{
            itemCollection.image = UIImage(named: "star_yes")
            NotificationCenter.default.post(name: NSNotification.Name(navigations), object: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let category = categorys![indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelectde(index: indexPath.row)
        if picker != nil {
            picker?.cancel()
        }
    }
    
    private let actionCellReuseId = "actionCell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: actionCellReuseId, for: indexPath) as! ActionCollectionViewCell
        let category = categorys![indexPath.row]
        cell.lblTitle.text = category.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectde(index: indexPath.row)
        if pickerOfCollection != nil {
            pickerOfCollection?.cancel()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
