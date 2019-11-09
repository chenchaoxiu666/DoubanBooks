//
//  ActionCollectionPicker.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/9.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
class ActionCollectionPicker: UIView {
    var delegate:UICollectionViewDelegate?
    var dataSource:UICollectionViewDataSource?
    let rowHeihgt = 60
    var onRect = UIScreen.main.bounds
    var offRect: CGRect = {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        return CGRect(x: 0, y: h, width: w, height: h)
    }()
    
    var bgMask: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.lightGray
        mView.alpha = 0.5
        return mView
    }()
    
    fileprivate func addTitle(title: String, itemsCount: Int){
        let n = getRows(itemsCount)
        let y = self.bounds.height - CGFloat((n + 1) * rowHeihgt + rowHeihgt + 20 + rowHeihgt + 10 + 2 )
        let lblTitle  = UILabel(frame: CGRect(x: 20, y: y, width: self.bounds.width - 40, height: CGFloat(rowHeihgt + 10)))
        lblTitle.textAlignment = .center
        lblTitle.backgroundColor = UIColor.white
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lblTitle.text = title
        self.addSubview(lblTitle)
    }
    
    fileprivate func addCollectionView(_ count:Int,reuseId:String) {
       let n = getRows(count)
        let y = self.bounds.height - CGFloat(n * (rowHeihgt + 10) + rowHeihgt + 20 + 20)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat((UIScreen.main.bounds.width - 80)/3), height: CGFloat(rowHeihgt))
        layout.minimumLineSpacing = CGFloat(10)
        layout.minimumInteritemSpacing = CGFloat(10)
        let table = UICollectionView(frame: CGRect(x: 20, y: y, width: UIScreen.main.bounds.width - 40 , height: CGFloat(n * (rowHeihgt + 10) + 20)), collectionViewLayout: layout)
        table.dataSource = dataSource
        table.delegate = delegate
        table.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: reuseId)
        table.backgroundColor = UIColor.groupTableViewBackground
        table.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.addSubview(table)
    }
    func getRows(_ count:Int) -> Int{
        var n = 1
        if count < 3 {
            n = count
        } else{
            n = 3
        }
        return n
    }
    
    fileprivate func addCancel(){
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: self.bounds.height - CGFloat(rowHeihgt), width: self.bounds.width - 40 , height: CGFloat(rowHeihgt))
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.setTitle("取消", for: .normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    @objc func cancel(){
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            self.frame = self.offRect
        }, completion: {over in
            self.removeFromSuperview()
        })
    }
    
    func show(superView:UIView) -> ActionCollectionPicker{
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            self.frame = self.onRect
            self.removeFromSuperview()
            superView.addSubview(self)
        })
        return self
    }
    
    init(title: String, count:Int,dataSource:UICollectionViewDataSource,delegate:UICollectionViewDelegate,reusdId:String) {
        super.init(frame: onRect)
        self.dataSource = dataSource
        self.delegate = delegate
        self.frame = offRect
        self.backgroundColor = UIColor.clear
        bgMask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancel)))  /// 点击空白处执行cancel方法
        self.bgMask.frame = self.bounds
        self.addSubview(bgMask)
        addCancel()
        addCollectionView(count, reuseId: reusdId)
        addTitle(title: title, itemsCount: count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
