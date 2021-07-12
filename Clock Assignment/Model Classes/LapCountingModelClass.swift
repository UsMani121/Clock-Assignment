//
//  LapCountingModelClass.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 09/07/2021.
//

import Foundation
class LapCountingModelClass{
    
    var lapTime = ""
    var lapCount = 0
    
    init(lapTime : String , lapCount : Int) {
        self.lapTime = lapTime
        self.lapCount = lapCount
    }
    
    init(lapCount : Int) {
        self.lapCount = lapCount
    }
    init(lapTime : String ) {
        self.lapTime = lapTime
    }
}
