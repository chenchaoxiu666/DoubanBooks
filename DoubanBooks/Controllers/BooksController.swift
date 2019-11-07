//
//  BooksController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/22.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class BooksController: UITableViewController ,EmptyViewDelegate{
    var categories = VMCategoty()
    var books: [VMBook]?
    let bookSuge = "bookSuge"
    let bookcell = "bookcell"
    
     let factory = BookFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            books = try factory.getBooksOf(category: categories.id)
        }catch DataError.readCollectionError(let info){
            books = [VMBook]()
            UIAlertController.showALertAndDismiss(info, in: self, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }catch{
            books = [VMBook]()
            UIAlertController.showALertAndDismiss(error.localizedDescription, in: self, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
        tableView.setEmtpyTableViewDelegate(target: self)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: navigations), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reload(){
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookcell, for: indexPath) as! BookCell
         let book = books![indexPath.row]
        cell.lblBookName.text = book.title
        cell.lblName.text = book.author
        cell.textSyonpsis.text = book.summary
        Alamofire.request(book.image!).responseImage{ response in
            if let imag = response.result.value {
               cell.imgCover.image = imag
            }
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: bookSuge, sender: indexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let book = self.books![indexPath.row]
            let (s, _) =  try! factory.removeBook(book: books![indexPath.row])
            if s {
                books = try? factory.getBooksOf(category: categories.id)
                tableView.reloadData()
            }

        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == bookSuge {
            let destinatons = segue.destination as! BookDateController
//            if sender is Int {
                let book = self.books![sender as! Int]
                destinatons.book = book
                destinatons.category = categories
                destinatons.readonly = true
//            }
    }
 
    }
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
}
