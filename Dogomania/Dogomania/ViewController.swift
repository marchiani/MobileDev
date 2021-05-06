//
//  ViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 23.02.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Result: UILabel!
    
    @IBOutlet var Same: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var FirstTimeSeconds: UITextField!
    
    @IBOutlet weak var FirstTimeMinutes: UITextField!
    
    @IBOutlet weak var FirstTimeHours: UITextField!
    
    @IBOutlet weak var Toggle: UISwitch!
    
    
    @IBOutlet weak var SecondTimeSeconds: UITextField!
    
    @IBOutlet weak var SecondTimeMinutes: UITextField!
    
    @IBOutlet weak var SecondTimeHours: UITextField!
    
    
    @IBAction func Button(_ sender: Any) {
        if(Toggle.isOn){
            var seconds : UInt! = 0
            if(FirstTimeSeconds.text?.count != 0){
                seconds = UInt(FirstTimeSeconds.text!)
            }
            
            var minutes : UInt! = 0
            if(FirstTimeMinutes.text?.count != 0){
                minutes = UInt(FirstTimeMinutes.text!)
            }
            
            var hours : UInt! = 0
            if(FirstTimeHours.text?.count != 0){
                hours = UInt(FirstTimeHours.text!)
            }
            
            let time = TimeBD(second: seconds, minutes: minutes, hours: hours)
            let defaultTime  = TimeBD()
            let result = defaultTime.AddTime(time: time)
            Result.text = result.FormatTime()
        }
        else {
            var seconds : UInt! = 0
            if(FirstTimeSeconds.text?.count != 0){
                seconds = UInt(FirstTimeSeconds.text!)
            }
        
            var minutes : UInt! = 0
            if(FirstTimeMinutes.text?.count != 0){
                minutes = UInt(FirstTimeMinutes.text!)
            }
            
            var hours : UInt! = 0
            if(FirstTimeHours.text?.count != 0){
                hours = UInt(FirstTimeHours.text!)
            }
            
            var secondSeconds : UInt! = 0
            if(SecondTimeSeconds.text?.count != 0){
                secondSeconds = UInt(SecondTimeSeconds.text!)
            }
            
            var secondMinutes : UInt! = 0
            if(SecondTimeMinutes.text?.count != 0){
                secondMinutes = UInt(SecondTimeMinutes.text!)
            }
            
            var secondHours : UInt! = 0
            if(SecondTimeHours.text?.count != 0){
                secondHours = UInt(SecondTimeHours.text!)
            }
            
            let firstTime = TimeBD(second: seconds, minutes: minutes, hours: hours)
            let secondTime = TimeBD(second: secondSeconds, minutes: secondMinutes, hours: secondHours)
            let defaultTime  = TimeBD()
            let result = defaultTime.TimeSum(firstTime: firstTime, secondTime: secondTime);
            
            Result.text = result.FormatTime()
        }
    }
    
    @IBAction func Substraction(_ sender: Any) {
        if(Toggle.isOn){
            var seconds : UInt! = 0
            if(FirstTimeSeconds.text?.count != 0){
                seconds = UInt(FirstTimeSeconds.text!)
            }
            
            var minutes : UInt! = 0
            if(FirstTimeMinutes.text?.count != 0){
                minutes = UInt(FirstTimeMinutes.text!)
            }
            
            var hours : UInt! = 0
            if(FirstTimeHours.text?.count != 0){
                hours = UInt(FirstTimeHours.text!)
            }
            
            let time = TimeBD(second: seconds, minutes: minutes, hours: hours)
            let defaultTime  = TimeBD()
            let result = defaultTime.ReduceTime(time: time)
            Result.text = result.FormatTime()
        }
        else {
            var seconds : UInt! = 0
            if(FirstTimeSeconds.text?.count != 0){
                seconds = UInt(FirstTimeSeconds.text!)
            }
        
            var minutes : UInt! = 0
            if(FirstTimeMinutes.text?.count != 0){
                minutes = UInt(FirstTimeMinutes.text!)
            }
            
            var hours : UInt! = 0
            if(FirstTimeHours.text?.count != 0){
                hours = UInt(FirstTimeHours.text!)
            }
            
            var secondSeconds : UInt! = 0
            if(SecondTimeSeconds.text?.count != 0){
                secondSeconds = UInt(SecondTimeSeconds.text!)
            }
            
            var secondMinutes : UInt! = 0
            if(SecondTimeMinutes.text?.count != 0){
                secondMinutes = UInt(SecondTimeMinutes.text!)
            }
            
            var secondHours : UInt! = 0
            if(SecondTimeHours.text?.count != 0){
                secondHours = UInt(SecondTimeHours.text!)
            }
            
            let firstTime = TimeBD(second: seconds, minutes: minutes, hours: hours)
            let secondTime = TimeBD(second: secondSeconds, minutes: secondMinutes, hours: secondHours)
            let defaultTime  = TimeBD()
            let result = defaultTime.TimeSubtraction(firstTime: firstTime, secondTime: secondTime);
            
            Result.text = result.FormatTime()
        }
    }
}
