//
//  ContainerController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class ContainerController: UIViewController, PageContainerDelegate{
    @IBOutlet var vIndictor1: UIView!
    @IBOutlet var vIndictor2: UIView!
    @IBOutlet var vIndictor3: UIView!
    var indicators:[UIView]!
    var controller:ChartsPageController!
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = (children.first as! ChartsPageController)
        controller.container = self
        indicators = [vIndictor1,vIndictor2,vIndictor3]
       
    }
    @IBAction func tapToChangeChart(_ sender: UIButton) {
        let index = sender.tag
        controller.setPage(to: index)
        switchTabButton(to: index)
    }
    
    func switchTabButton(to index: Int) {
        for indicator in indicators {
            if indicators.firstIndex(of: indicator) == index {
                indicator.backgroundColor = UIColor.blue
            } else {
                indicator.backgroundColor = UIColor.lightGray
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
