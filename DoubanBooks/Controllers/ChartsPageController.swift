//
//  ChartsPageController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class ChartsPageController: UIPageViewController, UIPageViewControllerDataSource {
   
    
    var container:PageContainerDelegate?
    private  lazy var controllers:[UIViewController] = {
        return [getController(identifier: "chart1"),getController(identifier: "chart2"),getController(identifier: "chart3")]
    }()
    
    private func getController(identifier:String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let chart1Controller = controllers.first {
            setViewControllers([chart1Controller], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {return nil}
        container?.switchTabButton(to: index) // 指示容器controller更新当前显示的指示为蓝条
        let prevIndex = index - 1
        guard prevIndex >= 0 else {
            return controllers.last
        }
        guard prevIndex < controllers.count else{
            return nil
        }
        return controllers[prevIndex]
    }
    // 为蓉区Controller提供切换页面的功能，在容器Controller中调用（点击切换按钮时）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else {return nil}
        container?.switchTabButton(to: index)
        let prevIndex = index + 1
        guard prevIndex != controllers.count else {
            return controllers.first
        }
        guard prevIndex < controllers.count else{
            return nil
        }
        return controllers[prevIndex]
    }
    
    func setPage(to index:Int) {
        if index >= 0 && index < controllers.count {
            setViewControllers([controllers[index]], direction: .forward, animated: true, completion: nil)
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
