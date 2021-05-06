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
    var pieChart = PieChartView();
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBOutlet weak var Toggle: UISwitch!
    
    @IBAction func Toggle(_ sender: Any) {
        if(Toggle.isOn){
            lineChart.delegate = self

            lineChart.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

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
        } else {
            pieChart.delegate = self
            pieChart.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

            pieChart.center = view.center
            view.addSubview(pieChart)
            
            var entrius = [ChartDataEntry] ()
            
            entrius.append(ChartDataEntry(x: 25, y: 25))
            entrius.append(ChartDataEntry(x: 45, y: 45))
            entrius.append(ChartDataEntry(x: 30, y: 30))
            let set = PieChartDataSet(entries: entrius)
            set.colors = ChartColorTemplates.joyful()

            let data = PieChartData(dataSet: set)

            pieChart.data = data
        }
        
    }
    override func viewDidLayoutSubviews() {
        
        
        
        
        super.viewDidLayoutSubviews()
        pieChart.delegate = self
        pieChart.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

        pieChart.center = view.center
        view.addSubview(lineChart)
        
        var entrius = [ChartDataEntry] ()
        
        entrius.append(ChartDataEntry(x: 25, y: 25))
        entrius.append(ChartDataEntry(x: 45, y: 45))
        entrius.append(ChartDataEntry(x: 30, y: 30))
        let set = PieChartDataSet(entries: entrius)
        set.colors = ChartColorTemplates.joyful()

        let data = PieChartData(dataSet: set)

        pieChart.data = data
    }
    

}
