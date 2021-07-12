//
//  StopWatchViewController.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 08/07/2021.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet weak var stopWatchTableView: UITableView!
    @IBOutlet weak var stopWatchTimerLabel: UILabel!
    
    @IBOutlet weak var BtnStartPause: CustomUIButton!
    @IBOutlet weak var BtnLapReset: CustomUIButton!
    var customButton = CustomUIButton()
    
    var cellLapLabel: UILabel?
    
    var countingLap = 1
    var lappedTimeArray : [LapCountingModelClass] = []
    
    let stop = StopWatchCustomTableViewCell()
    
    var timer = Timer()
    var mainCount = 0.0
    var lapCount = 0.0
    var timerCounting : Bool = false
    override func viewDidLoad() {
      
        
        super.viewDidLoad()
        
        stopWatchTableView.delegate = self
        stopWatchTableView.dataSource = self
    
    }
    
    @IBAction func StartPauseBtnTapped(_ sender: Any) {
        
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            
        BtnLapReset.setTitle("Reset", for: .normal)
            BtnStartPause.setTitle("Start", for: .normal)
            BtnStartPause.setTitleColor(.green, for: .normal)
            BtnStartPause.backgroundColor = .red
        }
        else {
            timerCounting = true
            BtnLapReset.setTitle("Lap", for: .normal)
            BtnStartPause.setTitle("Stop", for: .normal)
            BtnStartPause.setTitleColor(.red, for: .normal)
            BtnStartPause.backgroundColor = .green
            
            if lappedTimeArray.isEmpty {
               // lappedTimeArray.append(countValueToTimerValue(count: lapCount))
                lappedTimeArray.insert(LapCountingModelClass(lapTime: countValueToTimerValue(count: lapCount), lapCount: countingLap), at: 0)
                
                countingLap += 1
                
                stopWatchTableView.reloadData()
                if let cell = stopWatchTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? StopWatchCustomTableViewCell {
                    self.cellLapLabel = cell.timerLabel
                }
                
            }
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func LapResetBtnTapped(_ sender: Any) {
        
        
        if !timerCounting {
            
        BtnLapReset.setTitle("Lap", for: .normal)
        self.mainCount = 0
        self.timer.invalidate()
        timerCounting = false
        
        stopWatchTimerLabel.text = "00:00:00"
       
        self.BtnStartPause.setTitle("Start", for: .normal)
        self.BtnStartPause.setTitleColor(.green, for: .normal)
        self.BtnStartPause.backgroundColor = .red
        self.BtnLapReset.setTitle("Lap", for: .normal)
            
            lappedTimeArray = []
            countingLap = 0
        stopWatchTableView.reloadData()
            
        }
        else{

            lappedTimeArray[0].lapTime = countValueToTimerValue(count: lapCount)
            lapCount = 0

            lappedTimeArray.insert(LapCountingModelClass(lapTime: countValueToTimerValue(count: lapCount), lapCount: countingLap) , at: 0)
            
            stopWatchTableView.reloadData()
            countingLap += 1
            
        }
        
    }
    
    
    @objc func timerCounter() -> Void {
        
        
        mainCount += 0.1
        lapCount += 0.1
        
        
        stopWatchTimerLabel.text = countValueToTimerValue(count: mainCount)
        if let label = cellLapLabel {
            label.text = countValueToTimerValue(count: lapCount)
        }
       
     
    }
    
    func countValueToTimerValue(count: Double) -> String {
        let flooredCounter = Int(floor(count))
        let hour = flooredCounter / 3600
        let minutes = (flooredCounter % 3600) / 60
        var minuteString = "\(minutes)"
        if minutes < 10 {
            minuteString = "0\(minutes)"
        }
        
        let seconds = (flooredCounter % 3600) % 60
        var secondString = "\(seconds)"
        if seconds < 10 {
            secondString = "0\(seconds)"
        }
        
        let deciSecond = String(format: "%.2f", count).components(separatedBy: ".").last!
        
        return "\(hour):\(minuteString):\(secondString):\(deciSecond)"
    }
    
}


extension StopWatchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return lappedTimeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell", for: indexPath) as! StopWatchCustomTableViewCell
//      cell.textLabel?.text = "Lap \(indexPath.row) \(lappedTimeArray[indexPath.row])"
//        cell.textLabel?.textColor = UIColor.white
        
        cell.lapLabel.text = "Lap \(lappedTimeArray[indexPath.row].lapCount)"
        cell.timerLabel.text = lappedTimeArray[indexPath.row].lapTime


        return cell
    }
    
    
}
