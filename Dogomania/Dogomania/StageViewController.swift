//
//  StageViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import UIKit
import Charts

class StageViewController: UIViewController, ChartViewDelegate {
    var lineChart = LineChartView();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        
        
        
        super.viewDidLayoutSubviews()

        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entrius = [ChartDataEntry] ()
        
        for x in -5..<6 {
            entrius.append(ChartDataEntry(x: Double(x), y: Double(x*x)))
        }
        let set = LineChartDataSet(entries: entrius)
        set.colors = ChartColorTemplates.joyful()

        let data = LineChartData(dataSet: set)

        lineChart.data = data
    }
    

}
