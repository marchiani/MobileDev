//
//  StageViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import UIKit
import Charts

class StageViewController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        
        
        
        super.viewDidLayoutSubviews()

        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entrius = [ChartDataEntry] ()
        
        entrius.append(ChartDataEntry(x: Double(35), y: Double(35)))
        entrius.append(ChartDataEntry(x: Double(40), y: Double(40)))
        entrius.append(ChartDataEntry(x: Double(25), y: Double(25)))

        let set = PieChartDataSet(entries: entrius)
        set.colors = ChartColorTemplates.material()

        let data = PieChartData(dataSet: set)
        #imageLiteral(resourceName: "simulator_screenshot_364D3EEB-8A8D-4D80-80C1-790F751AEFBE.png")
        pieChart.data = data
    }
    

}
