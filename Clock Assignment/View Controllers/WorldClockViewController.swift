//
//  ViewController.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 07/07/2021.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    
    var worldClockArray : [WorldClockModelClass] = []
   
    
//    var worldCloclkArray : [WorldClockModelClass] = [
//        WorldClockModelClass(name: "Karachi", minutes: "23", hours: "12:23", diff_hours: "+0HRS", day: "Today", am_pm: "am"),
//WorldClockModelClass(name: "Sydney", minutes: "32", hours: "03:31", diff_hours: "+12HRS", day: "Today,", am_pm: "pm"),
//WorldClockModelClass(name: "Delhi", minutes: "14", hours: "01:12", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
//WorldClockModelClass(name: "Istanbul", minutes: "41", hours: "11:54", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
//WorldClockModelClass(name: "Kabul", minutes: "51", hours: "04:42", diff_hours: "+12HRS", day: "Today,", am_pm: "pm"),
//WorldClockModelClass(name: "Dhaka", minutes: "12", hours: "04:12", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
// WorldClockModelClass(name: "Karachi", minutes: "23", hours: "12:54", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
//        WorldClockModelClass(name: "Karachi", minutes: "23", hours: "12:32", diff_hours: "+0HRS", day: "Today", am_pm: "am"),
//WorldClockModelClass(name: "Sydney", minutes: "32", hours: "03:12", diff_hours: "+12HRS", day: "Today,", am_pm: "pm"),
//WorldClockModelClass(name: "Delhi", minutes: "14", hours: "01:54", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
//WorldClockModelClass(name: "Istanbul", minutes: "41", hours: "11:21", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
//WorldClockModelClass(name: "Kabul", minutes: "51", hours: "04:14", diff_hours: "+12HRS", day: "Today,", am_pm: "pm"),
//WorldClockModelClass(name: "Dhaka", minutes: "12", hours: "04:11", diff_hours: "+12HRS", day: "Today,", am_pm: "am"),
// WorldClockModelClass(name: "KarachiKarachiKarachiKarachi", minutes: "23", hours: "12:54", diff_hours: "+12HRS", day: "Today,", am_pm: "am")
//    ]

    @IBOutlet weak var worldClockTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        worldClockTableView.delegate = self
        worldClockTableView.dataSource = self
        worldClockTableView.sectionIndexTrackingBackgroundColor = .green
        
        // Do any additional setup after loading the view.
    }
    
    
    
    

    @IBAction func goToCoiuntryListVC(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CountryListViewController") as! CountryListViewController
        
        vc.countryListVCDelegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
       
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if worldClockTableView.isEditing{
            worldClockTableView.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            
        }else{
            worldClockTableView.isEditing = true
            self.navigationItem.leftBarButtonItem?.title = "Done"
             
        }
        worldClockTableView.reloadData()
    }
    
    

      
    
}

extension WorldClockViewController : UITableViewDelegate , UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        worldClockTableView.tintColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = worldClockTableView.dequeueReusableCell(withIdentifier: "WorldClockCell", for: indexPath) as! WorldClockCustomTableViewCell
        
        
//        cell.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        
        
        cell.amPmLabel.text = worldClockArray[indexPath.row].am_pm
        cell.cityLabel.text = worldClockArray[indexPath.row].name
        cell.dayLabel.text =  worldClockArray[indexPath.row].day
        cell.differenceHoursLabel.text =  worldClockArray[indexPath.row].gmt
        cell.hoursLabel.text =  worldClockArray[indexPath.row].hours
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        worldClockArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        worldClockTableView.beginUpdates()
        
        worldClockArray.remove(at: indexPath.row)
        worldClockTableView.deleteRows(at: [indexPath], with: .fade)
        
        worldClockTableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension WorldClockViewController : CountryListViewControllerDelegate{
    func countryListViewController(_ countryViewController: CountryListViewController, countryname: String, countryGMT: String) {
        
        worldClockArray.append(WorldClockModelClass(name: countryname, minutes: "11", hours: "11", diff_hours: "+!!HRS", day: "11", am_pm: "11" , gmt: countryGMT))
        worldClockTableView.reloadData()
        
        
    }
    
    
     
    }
    
    


