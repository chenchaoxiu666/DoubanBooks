//
//  UserCookies.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/13.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import Foundation
let notiUpdateRecordds = "UserCookies.notiUpdateRecordds"
let notiUpdateKeywords = "UserCookies.notiUpdateKeywords"
class UserCookies {
    static let pathOfCategoryRecords = NSHomeDirectory().appending("/Documents/").appending("cateoogryrecords.data")
    static let pathOfTopKeywords = NSHomeDirectory().appending("/Documents/").appending("topkeywords.data")
    
    static func getRecords(of category:UUID) -> Int {
        let dic = NSMutableDictionary(contentsOfFile: pathOfCategoryRecords)
        if let count = dic?[category.uuidString] as? Int {
            return count
        }
        return 0
    }
    
    static func updateRecords(of caregory:UUID, count: Int) {
        var dic = NSMutableDictionary(contentsOfFile: pathOfCategoryRecords)
        if dic == nil {
            dic = NSMutableDictionary()
        }
        dic?.setObject(count, forKey: caregory.uuidString as NSCopying)
        dic?.write(toFile: pathOfCategoryRecords, atomically: true)
        NotificationCenter.default.post(name: NSNotification.Name(notiUpdateRecordds), object: nil)
    }
    
    static func getFrequency(of keyword: String) -> Int {
        let dic = NSMutableDictionary(contentsOfFile: pathOfTopKeywords)
        if let count = dic?[keyword] as? Int {
            return count
        }
        return 0
    }
    
    static func updateFrequency(of keyword: String) {
        var dic = NSMutableDictionary(contentsOfFile: pathOfTopKeywords)
        if dic == nil {
            dic = NSMutableDictionary()
        }
        let count = getFrequency(of: keyword) + 1
        dic?.setObject(count, forKey: keyword as NSCopying)
        dic?.write(toFile: pathOfTopKeywords, atomically: true)
        NotificationCenter.default.post(name: NSNotification.Name(notiUpdateKeywords), object: nil)
    }
    
    static func getTopKeywords(top:Int) -> [(String, Int)] {
        var keywords  = [(String, Int)]()
        let dic = NSMutableDictionary(contentsOfFile: pathOfTopKeywords)
        guard let theDic = dic else { return keywords}
        for (key, value) in theDic {
            keywords.append((key as! String, value as! Int))
        }
        let sorted = keywords.sorted(by: {$0.1 > $1.1})
        if sorted.count <= top{
            return sorted
        }
        return [(String,Int)]() + sorted[0...top-1]
    }
}
