//
//  CategoryReadingStatisticsController.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/11/12.
//  Copyright © 2019年 2017yd. All rights reserved.
//

import UIKit
import AAInfographics
class CategoryReadingStatisticsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: notiUpdateRecordds), object: nil)
        reload()
    }
    @objc func reload(){
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
        var dic = [Any]()
        var dd = [String]()
        for item in items {
            let count = UserCookies.getRecords(of: item.id)
            dic.append([item.name!,count])
            dd.append(item.name!)
        }
        
        let chrModel = AAChartModel()
            .chartType(.pie)
            .title("不同类别图书访问量统计")
            //            .subtitle("")
            .categories(dd )
            .colorsTheme(gradientColorArr as [Any])
            .dataLabelsEnabled(true)
            .series([
                AASeriesElement()
//                    .name(dd[0])
                    .allowPointSelect(false)
                    .data(dic),
                ])
        chart.aa_drawChartWithChartModel(chrModel)
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
