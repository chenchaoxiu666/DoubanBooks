//
//  CategorisesController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/18.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import UIKit

private let reuseIdentifier = "categoryCell"

class CategorisesController: UICollectionViewController {
    var categories: [VMCategoty]?
    
    let addCategorySegu = "addCategorySegu"
    let BooksSegu = "BooksSegu"
    
    let factory = CategotyFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
          categories = try factory.getAllCategories()
        }catch DataError.readCollectionError(let info){
            categories = [VMCategoty]()
            UIAlertController.showALertAndDismiss(info, in: self)
        }catch{
            categories = [VMCategoty]()
        }
        /// selector：要做什么
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: notiCategory), object: nil)
        
    }
    /// 接受数据
    @objc func refresh(noti: Notification){
        //刷新
        ///使用键来获取值
        let name = noti.userInfo!["name"] as! String
        do{
            categories?.removeAll()
            categories?.append(contentsOf: try factory.getAllCategories())
            UIAlertController.showALertAndDismiss("\(name)添加成功！", in: self, completion: {
                self.navigationController?.popViewController(animated: true)
                self.collectionView.reloadData()
                })

        }catch DataError.readCollectionError(let info){
            categories = [VMCategoty]()
            UIAlertController.showALertAndDismiss(info, in: self)
        }catch{
            categories = [VMCategoty]()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        let category = categories![indexPath.item]
        cell.lblName.text = category.name!
        cell.lblCount.text = String(factory.getBooksCountOfCategory(category: category.id)!)
        // TODO: 图库文件保存到沙盒，取文件地址
        cell.imgCover.image = UIImage(contentsOfFile: NSHomeDirectory().appending(imgDir).appending(category.image!))
        cell.lblEditTime.text = CategotyFactory.getEditTimeFromPlist(id: category.id)
        cell.btnDelete.isHidden = true // TODO:随普通模式和删除模式切换可见
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        UIAlertController.showALertAndDismiss("\(indexPath.row)", in: self)
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
