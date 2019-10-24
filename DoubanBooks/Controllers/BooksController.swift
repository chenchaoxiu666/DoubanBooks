//
//  BooksController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/22.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class BooksController: UITableViewController ,EmptyViewDelegate{
    var categories = VMCategoty()
    var books: [VMBook]?
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
//        cell.lblName.text = book.authorIntro
        cell.lblSynopsis.text = book.summary
//        cell.imgCover.image = UIImage(contentsOfFile: NSHomeDirectory().appending(imgDir).appending(categories.image!))
        cell.imgNameCover.image = UIImage(named: "ic_user")
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
}
