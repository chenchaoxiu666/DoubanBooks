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

let navigation = "BookDateController.navigation"
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
    var book = VMBook()
    var star = "star_no"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(book.image!).responseImage{ response in
            if let imag = response.result.value {
                self.imgCover.image = imag
            }
        }
        self.lblUserName.text = book.author
        self.lblPublisher.text = book.publisher
        self.lblPubdate.text = book.pubdate
        self.lblPrice.text = book.price
        self.textAuthor.text = book.authorIntro
        self.textSummary.text = book.summary
        angTitle.title = book.title
        if (try? factory.isBookExists(book: book)) ?? false{
            star = "star_yes"
        }
        itemCollection.image = UIImage(named: star)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        
//        if star == "star_no" {
//           if (try?factory.isBookExists(book: book)) ?? false{
//                try? factory.removeBook(id: book.id)
//            }
//        } else {
//            if (try?factory.isBookExists(book: book)) ?? false{
//                try? factory.addBook(cattegory: book)
//            }
//        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: navigation), object: nil, userInfo: ["title":book.title])
    }
    
    
    
    
    @IBAction func collectionAction(_ sender: Any) {
        if star == "star_no" {
            itemCollection.image = UIImage(named: "star_yes")
            star = "star_yes"
        } else {
            itemCollection.image = UIImage(named: "star_no")
            star = "star_no"
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
