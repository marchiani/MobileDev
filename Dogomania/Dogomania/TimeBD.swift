//
//  TimeBD.swift
//  Dogomania
//
//  Created by SWAN mac on 29.04.2021.
//

import Foundation

class TimeBD {
    var Seconds: UInt
    var Minutes: UInt
    var Hours: UInt
    
    enum TimeError: Error {
        case runtimeError(String)
    }
    
    init(second: UInt, minutes: UInt, hours: UInt) {
        
        if(second > 60){
            print("Seconds can not be bigger then 60")
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        if(second < 0){
            print("Seconds can not be less then 0")
            
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        
        if(minutes > 60){
            print("minutes can not be bigger then 60")
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        if(minutes < 0){
            print("minutes can not be less then 0")
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        
        if(hours > 24){
            print("Seconds can not be bigger then 24")
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        if(hours < 0){
            print("Seconds can not be less then 60")
            Seconds = 0
            Minutes = 0
            Hours = 0
            return;
        }
        
        Seconds = second
        Minutes = minutes
        Hours = hours
    }
    
    init(date: Date) {
        let calendar = Calendar.current
        
        Seconds = UInt(calendar.component(.second, from: date))
        Minutes = UInt(calendar.component(.minute, from: date))
        Hours = UInt(calendar.component(.hour, from: date))
    }
    
    init() {
        let date = Date()
        let calendar = Calendar.current
        
        Seconds = UInt(calendar.component(.second, from: date))
        Minutes = UInt(calendar.component(.minute, from: date))
        Hours = UInt(calendar.component(.hour, from: date))
    }
    
    func FormatTime() -> String {
        return "\(Hours):\(Minutes):\(Seconds)";
        }
    
    func AddTime(time: TimeBD) -> TimeBD {
        
        var reduceSeconds : UInt = UInt(time.Seconds + Seconds)
        var reduceMinutes : UInt = UInt(time.Minutes + Minutes)
        var reduceHours : UInt = UInt(time.Hours + Hours)
        
        if(reduceSeconds > 60){
            reduceSeconds = reduceSeconds - 60
            reduceMinutes = reduceMinutes + 1
        }
        
        if(reduceMinutes > 60) {
            reduceMinutes = reduceMinutes - 60
            reduceHours = reduceHours + 1
        }
        
        if(reduceHours > 24){
            reduceHours = reduceHours - 24
        }
        
        return TimeBD(second: reduceSeconds, minutes: reduceMinutes, hours: reduceHours)
    }
    
    
    func ReduceTime(time: TimeBD) -> TimeBD {
        
        var reduceSeconds  = Seconds - time.Seconds
        var reduceMinutes  = Minutes - time.Minutes
        var reduceHours = Hours - time.Hours
        
        if(reduceSeconds < 0){
            reduceSeconds = 60 + reduceSeconds
            reduceMinutes = reduceMinutes - 1
        }
        
        if(reduceMinutes < 0){
            reduceMinutes = 60 + reduceMinutes
            reduceHours = reduceHours - 1
        }
        
        if(reduceHours < 0){
            reduceHours = 24 + reduceHours
        }
        return TimeBD(second: UInt(reduceSeconds), minutes: UInt(reduceMinutes), hours: UInt(reduceHours))
    }
    
    func TimeSum(firstTime: TimeBD, secondTime: TimeBD) -> TimeBD {
        var reduceSeconds  = firstTime.Seconds + secondTime.Seconds
        var reduceMinutes = firstTime.Minutes + secondTime.Minutes
        var reduceHours = firstTime.Hours + secondTime.Hours
        
        if(reduceSeconds > 60){
            reduceSeconds = reduceSeconds - 60
            reduceMinutes = reduceMinutes + 1
        }
        
        if(reduceMinutes > 60) {
            reduceMinutes = reduceMinutes - 60
            reduceHours = reduceHours + 1
        }
        
        if(reduceHours > 24){
            reduceHours = reduceHours - 24
        }
        
        return TimeBD(second: UInt(reduceSeconds), minutes: UInt(reduceMinutes), hours: UInt(reduceHours))
    }
    
    func TimeSubtraction(firstTime: TimeBD, secondTime: TimeBD) -> TimeBD {
        var reduceSeconds = firstTime.Seconds - secondTime.Seconds
        var reduceMinutes = firstTime.Minutes - secondTime.Minutes
        var reduceHours = firstTime.Hours - secondTime.Hours
        
        if(reduceSeconds < 0){
            reduceSeconds = 60 + reduceSeconds
            reduceMinutes = reduceMinutes - 1
        }
        
        if(reduceMinutes < 0){
            reduceMinutes = 60 + reduceMinutes
            reduceHours = reduceHours - 1
        }
        
        if(reduceHours < 0){
            reduceHours = 24 + reduceHours
        }
        return TimeBD(second: UInt(reduceSeconds), minutes: UInt(reduceMinutes), hours: UInt(reduceHours))
    }
}
