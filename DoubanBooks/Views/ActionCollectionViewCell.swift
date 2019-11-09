//
//  ActionCollectionViewCell.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/9.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    var lblTitle:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        lblTitle = UILabel()
        lblTitle.font = UIFont.systemFont(ofSize: 13)
        lblTitle.textAlignment = .center
        lblTitle.textColor = UIColor.black
        self.addSubview(lblTitle)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.lblTitle.frame = CGRect(x: 0, y: 0, width:self.bounds.width , height: 60)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
