//
//  DueTimeTableViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 10/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit
import UserNotifications

struct stopDueTimeInformation {
    let busRoute: String?
    let dueTime: String?
}
var a = 0
class DueTimeTableViewController: UITableViewController {
    
    var checkBusStop: String = ""
    var dueTime: DueTimeJson!
    var stopDueTimeInformations: [stopDueTimeInformation] = []
    
    var reminderBus: String = ""
    var ReminderDueTime: String = ""
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var settingUpReminderView: UIView!
    @IBOutlet weak var cancelReminder: UIButton!
    @IBOutlet weak var setReminder: UIButton!
    
    @IBOutlet weak var timerOptionForSlider: UILabel!
    
    @IBOutlet weak var sliderForTimer_Outlet: UISlider!
    @IBAction func sliderForTimer(_ sender: UISlider) {
        timerOptionForSlider.text = String(Int(sender.value))
    }
    
    var effect:UIVisualEffect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none //disables the cell lines
        effect = blurView.effect
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
            if didAllow {
                
            }
        })
    
        settingUpReminderView.layer.cornerRadius = 5
        
        dueTime = DueTimeJson(stopid: checkBusStop)
        dueTime.getStopDueTime { (dueTimeNSArray) in
            if let dueTimeNSArray = dueTimeNSArray {
                              DispatchQueue.main.async {
            for stopDueTime in dueTimeNSArray {
                //print(dueTime)
                var dueTime = (stopDueTime as? NSDictionary)?["duetime"] as? String ?? ""
                var route = (stopDueTime as? NSDictionary)?["route"] as? String ?? ""
                self.stopDueTimeInformations.append(stopDueTimeInformation(busRoute: route, dueTime: dueTime))
                //print(route)
               }
                 self.tableView.reloadData()
              }
            }
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stopDueTimeInformations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dueCell", for: indexPath) as? DueTimeTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCell.")
        }
        
        let dueTime = stopDueTimeInformations[indexPath.row].busRoute
        let route = stopDueTimeInformations[indexPath.row].dueTime

        cell.dueTime.text = dueTime
        cell.route.text = route
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if stopDueTimeInformations[indexPath.row].dueTime != "Due" && stopDueTimeInformations[indexPath.row].dueTime != "1" {
            reminderBus = stopDueTimeInformations[indexPath.row].busRoute!
            ReminderDueTime = stopDueTimeInformations[indexPath.row].dueTime!
            
            var busDueTime = Float(stopDueTimeInformations[indexPath.row].dueTime!)
            sliderForTimer_Outlet.maximumValue = busDueTime! - 1
            sliderForTimer_Outlet.minimumValue = 1
            
            settingUpReminderViewAnimation()
        } else {
            print("BUS IS DUE")
        }
    }
    
    func settingUpReminderViewAnimation() {
        
        
        sliderForTimer_Outlet.setValue(3, animated: true)
        timerOptionForSlider.text = "3"
        
        self.view.addSubview(settingUpReminderView)

        //self.view.isUserInteractionEnabled = false
        self.blurView.isUserInteractionEnabled = false
        self.settingUpReminderView.isUserInteractionEnabled = true
        settingUpReminderView.center = self.view.center
        settingUpReminderView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3) //it is bigger so it will give it the scale down effect when it pops up
        settingUpReminderView.alpha = 0
        settingUpReminderView.layer.zPosition = 1
        
        blurView.frame = self.view.frame
        blurView.layer.zPosition = 0
        
        //will take .4 seconds for the following animation to occur
        UIView.animate(withDuration: 0.4) {
            self.view.addSubview(self.blurView)
            self.blurView.alpha = 0.7
            self.settingUpReminderView.alpha = 1
            self.settingUpReminderView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.33, animations: {
            self.settingUpReminderView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.settingUpReminderView.alpha = 0
            self.settingUpReminderView.transform = CGAffineTransform.identity
 
            
            
        }) { (success:Bool) in
            self.settingUpReminderView.removeFromSuperview()
            self.blurView.removeFromSuperview()
            //self.view.isUserInteractionEnabled = true
            self.settingUpReminderView.isUserInteractionEnabled = false
            
            
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @IBAction func cancelReminder_TouchUpInide(_ sender: UIButton) {
        animateOut()
    }
    
    @IBAction func setReminder_TouchUpInsdie(_ sender: UIButton) {
        
        animateOut()
        
                let reminder = UNMutableNotificationContent()
                reminder.title = "The bus \(reminderBus)"
        reminder.subtitle = "is due in \(Int(ReminderDueTime)! - Int(timerOptionForSlider.text!)!) minutes "
                reminder.body = "hurry.."
                reminder.badge = 1 //displays it in notification
        
        //mutiplying the picked reminder by 60 in order to get the minutes
        
        var timeSelectedConverted =  Double(timerOptionForSlider.text!)!
        print(type(of: timeSelectedConverted))
        var dueTimeConverted = Double(reminderBus)!
        print(type(of: dueTimeConverted))
        
        var timeSelected = (dueTimeConverted - timeSelectedConverted)
  
                var trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeSelected, repeats: false)//trigger the notification display
                let request = UNNotificationRequest(identifier: "busReminder", content: reminder, trigger: trigger)//request authorisation to display thr notification
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil) //added to notification center

        

    
    }
    
}
