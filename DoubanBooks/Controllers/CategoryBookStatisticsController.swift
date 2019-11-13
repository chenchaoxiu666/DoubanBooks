//
//  CategoryBookStatisticsController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import AAInfographics
class CategoryBookStatisticsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let chartWidth = UIScreen.main.bounds.width
        let chartHeight = UIScreen.main.bounds.height - 150
        let gradientColorArr = [
            AAGradientColor.oceanBlue,
            AAGradientColor.sanguine,
            AAGradientColor.lusciousLime,
            AAGradientColor.purpleLake,
            AAGradientColor.freshPapaya,
            AAGradientColor.ultramarine,
            AAGradientColor.pinkSugar,
            AAGradientColor.lemonDrizzle,
            AAGradientColor.victoriaPurple,
            AAGradientColor.springGreens,
            AAGradientColor.mysticMauve,
            AAGradientColor.reflexSilver,
            AAGradientColor.newLeaf,
            AAGradientColor.cottonCandy,
            AAGradientColor.pixieDust,
            AAGradientColor.fizzyPeach,
            AAGradientColor.sweetDream,
            AAGradientColor.firebrick,
            AAGradientColor.wroughtIron,
            AAGradientColor.deepSea,
            AAGradientColor.coastalBreeze,
            AAGradientColor.eveningDelight,
            ]
        if view.subviews.count > 0{
            let old = view.subviews[0]
            old.removeFromSuperview()
        }
        
        let chart = AAChartView()
        chart.frame = CGRect(x: 0, y: 0, width: chartWidth, height: chartHeight)
        view.addSubview(chart)
        let categories = try? CategotyFactory.getInstance(UIApplication.shared.delegate as! AppDelegate).getAllCategories()
        guard let items = categories else {return}
        var dic = [String]()
        var cc = [Any]()
        for item in items {
            let count = try? BookFactory.getInstance(UIApplication.shared.delegate as! AppDelegate).getBooksOf(category: item.id)
            dic.append(item.name!)
            cc.append(count?.count as Any)
        }
       
        let chrModel = AAChartModel()
            .chartType(.column)
            .title("图书类别统计")
//            .subtitle("")
            .categories(dic )
            .colorsTheme(gradientColorArr as [Any])
            .series([
                AASeriesElement()
                .name(dic[0])
                    .data([cc[0]]),
                AASeriesElement()
                    .name(dic[1])
                    .data([cc[1]]),
                
                AASeriesElement()
                .name(dic[2])
                    .data([cc[2]])
               
                ])
        chart.aa_drawChartWithChartModel(chrModel)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
