//
//  BookDateController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/2.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class BookDateController: UIViewController {
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblPubdate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var textAuthorIntro: UITextField!
    
    
    var book = VMBook()
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
