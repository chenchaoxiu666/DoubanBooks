//
//  FindControllerController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/31.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "bookItemCell"

class FindControllerController: UICollectionViewController , EmptyViewDelegate, UISearchBarDelegate{
    var category: VMCategoty?
    var books: [VMBook]?
    var isLoading = false
    var currentPage = 0
    var kw = ""
    let factory = BookFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setEmtpyCollectionViewDelegate(target: self)
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let hader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "serachHeader", for: indexPath) as! HeaderReusableView
        hader.seaechBar.delegate = self
        return hader
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let kw = searchBar.text {
            tabBarController?.viewControllers![1].tabBarItem.badgeValue = kw
        }
        isLoading = false
        currentPage = 0
        kw = searchBar.text!
        books?.removeAll()
        loadBooks(kw: searchBar.text!)
    }
    // MARK: UICollectionViewDataSource

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return books?.count ?? 0
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FindViewCell
        let book = books![indexPath.item]
        cell.lblName.text = book.title
        cell.lblUserName.text = book.author
        Alamofire.request(book.image!).responseImage{ response in
            if let imag = response.result.value {
                cell.imgCover.image = imag
            }
        }
        cell.imgStar.image = UIImage(named: "star_off")
        if (try? factory.isBookExists(book: book)) ?? false{
            cell.imgStar.image = UIImage(named: "star_on")
        }
        
        if !isLoading && indexPath.item == (books?.count)! - 1 {
            isLoading = true
            currentPage += 1
            loadBooks(kw: kw)
        }
        return cell
    }

    
    func loadBooks(kw: String){
        Alamofire.request(BooksJson.getSearchUrl(keyword: kw, page: currentPage))
        .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let json = response.result.value {
                        let books = BookConverter.getBooks(json: json)
                        if books == nil || books.count == 0 {
                            self.isLoading = true
                        } else {
                            if self.books == nil {
                                self.books = books
                            } else {
                                self.books! += books
                            }
                            self.collectionView.reloadData()
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = true
                    }
                case let .failure(error):
                    UIAlertController.showAlert("网络错误：\(error.localizedDescription)", in: self)
                    self.isLoading = true
                }
         }
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
    var isEmpty: Bool{
        get{
            if let data  = books {
                return data.count == 0
            }
            return true
        }
    }
    
    var imgEmpty:UIImageView?
    func createEmptyView() -> UIView? {
        if let empty = imgEmpty{
            return empty
        }
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        let batHeigHt = navigationController?.navigationBar.frame.height
        let img = UIImageView(frame: CGRect(x: (w-139)/2, y: (h-128)/2 - (batHeigHt ?? 0), width:139, height: 128))
        img.image = UIImage(named: "no_data")
        img.contentMode = .scaleAspectFit
        return img
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}
