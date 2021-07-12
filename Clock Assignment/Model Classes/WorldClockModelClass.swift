//
//  WorldClockModelClass.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 08/07/2021.
//

import Foundation

class WorldClockModelClass {
    
    var name : String = ""
    var minutes : String = ""
    var hours : String = ""
    var diff_hours : String = ""
    var day : String = ""
    var am_pm : String = ""
    var gmt : String = ""


    init(name : String ,minutes : String ,hours : String ,diff_hours : String ,
         day : String  , am_pm : String, gmt : String) {
        self.name = name
        self.minutes = minutes
        self.hours = hours
        self.diff_hours = diff_hours
        self.day = day
        self.am_pm = am_pm
        self.gmt = gmt
    }
    
}
