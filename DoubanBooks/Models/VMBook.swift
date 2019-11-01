//
//  VMBook.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/14.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import CoreData
import Foundation
class VMBook:NSObject,DataViewModilDelegate,JSONable {
    required init(json: Dictionary<String, Any>) {
        id = UUID()
        categoryId = UUID()
        title = json[json_books_title] as? String       //加?防止没有数据
        pages = Int32(json[json_books_pages] as? String ?? "0")
        authorIntro = json[json_books_authorIntro] as? String
        image = json[json_books_image] as? String
        isbn10 = json[json_books_isbn10] as? String ?? ""
        isbn13 = json[json_books_isbn13] as? String ?? ""
        price = json[json_books_price] as? String
        pubdate = json[json_books_pubdate] as? String
        publisher = json[json_books_publisher] as? String
        summary = json[json_books_summary] as? String
        binding = json[json_books_binding] as? String
        if json[json_books_author] is NSArray {
            let authors = json[json_books_author] as! NSArray
            author = ""
            for a in authors {
               author?.append(a as! String + ",")
            }
            if author!.count > 0{
                author?.removeLast()
            }
        }
    }
    
    
     var author: String?
     var authorIntro: String?
     var categoryId: UUID
     var id: UUID
     var image: String?
     var isbn10: String?
     var isbn13: String?
     var pages: Int32?
     var price: String?
     var pubdate: String?
     var publisher: String?
     var summary: String?
     var title: String?
     var binding: String?
    
    override init() {
        id = UUID()
        categoryId = UUID()
    }
    
    static let entityName = "Book"
    static let colId = "id"
    static let colCaregoryId = "categoryId"
    static let colAuthorIntro = "authorIntro"
     static let colAuthor = "author"
     static let colImage = "image"
     static let colIsbn10 = "isbn10"
     static let colIsbn13 = "isbn13"
     static let colPages = "pages"
     static let colPubdate = "pubdate"
     static let colPublisher = "publisher"
     static let colSummary = "summary"
     static let colTitle = "title"
     static let colBinding = "binding"
    static let colPrice = "price"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dic:Dictionary<String,Any?> = Dictionary<String,Any?>()
        dic[VMBook.colId] = id
        dic[VMBook.colCaregoryId] = categoryId
        dic[VMBook.colAuthorIntro] = authorIntro
        dic[VMBook.colAuthor] = author
        dic[VMBook.colImage] = image
        dic[VMBook.colIsbn10] = isbn10
        dic[VMBook.colIsbn13] = isbn13
        dic[VMBook.colPages] = pages
        dic[VMBook.colPubdate] = pubdate
        dic[VMBook.colPublisher] = publisher
        dic[VMBook.colSummary] = summary
        dic[VMBook.colTitle] = title
        dic[VMBook.colBinding] = binding
        dic[VMBook.colPrice] = price
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let category = result as! Book
        id = category.id!
        categoryId = category.categoryId!
        authorIntro = category.authorIntro
        author = category.author
        isbn10 = category.isbn10
        isbn13 = category.isbn13
        pages = category.pages
        pubdate = category.pubdate
        publisher = category.publisher
        summary = category.summary
        title = category.title
        binding = category.binding
        price = category.price
        image = category.image

    }
    
}
