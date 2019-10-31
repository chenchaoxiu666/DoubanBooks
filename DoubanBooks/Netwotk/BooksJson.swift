//
//  BooksJson.swift
//  DouBanBook
//
//  Created by 2017yd on 2019/10/28.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let json_tag_count = "count"
let json_tag_total = "total"
let json_tag_books = "books"
let json_books_authorIntro = "authorIntro"
let json_books_author = "author"
let json_books_image = "image"
let json_books_isbn13 = "isbn13"
let json_books_isbn10 = "isbn10"
let json_books_pages = "pages"
let json_books_pubdate = "pubdate"
let json_books_publisher = "publisher"
let json_books_summary = "summary"
let json_books_title = "title"
let json_books_binding = "binding"
let json_books_price = "price"
let json_books_id = "id"

class BooksJson {
    static func getSearchUrl(keyword: String, page: Int ) -> String{
        let url = "https://douban.uieee.com/v2/book/search?q=" + keyword + "&srart=" + String(page * 20)
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
 
}


