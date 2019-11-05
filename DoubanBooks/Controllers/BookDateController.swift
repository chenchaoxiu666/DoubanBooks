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
class BookDateController: UIViewController, UINavigationControllerDelegate{
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
    var book:VMBook?
    var category:VMCategoty?
    var star = "star_no"
    var readonly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
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
