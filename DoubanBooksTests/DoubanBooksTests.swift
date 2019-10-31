//
//  DoubanBooksTests.swift
//  DoubanBooksTests
//
//  Created by 2017yd on 2019/10/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//
import Alamofire
import XCTest
@testable import DoubanBooks

class DoubanBooksTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testGet(){
        Alamofire.request(BooksJson.getSearchUrl(keyword: "ios", page: 0))
            .validate(contentType: ["application/json"])
            .responseJSON{ response in
            switch response.result {
            case .success:
                if let json = response.result.value{
                    let books = BookConverter.getBooks(json: json)
                    XCTAssertEqual(books.count, 20)
                    XCTAssertEqual(books[0].title, "Effective Objective-C 2.0")
                    print(json)
                }
            case .failure(let error):
                print(error)
                
            }
        }
        }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {

    }
    
}


