//
//  Functions.swift
//  Playground
//
//  Created by Chris Smith on 11/08/2022.
//

import UIKit

class Functions : UIViewController{
    
//MARK: - CustomAlert
    func customAlert(title: String, message: String){
        // create the alert
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - For date countdown
        
       //Parameters can be removed if needed
    func updateTimeDifference(titleOfEvent: String, compYear: Int, compMonth: Int, compDay: Int, compHour: Int, compMin: Int){
        // Here we set the current date

            let date = NSDate()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)

            let currentDate = calendar.date(from: components)

            let userCalendar = Calendar.current

         // Here we set the due date. When the timer is supposed to finish
            let competitionDate = NSDateComponents()
            competitionDate.year = compYear
            competitionDate.month = compMonth
            competitionDate.day = compDay
            competitionDate.hour = compHour
            competitionDate.minute = compMin
            let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!

          //Here we change the seconds to hours,minutes and days
            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)


            //finally, here we set the variable to our remaining time
            let daysLeft = CompetitionDayDifference.day
            let hoursLeft = CompetitionDayDifference.hour
            let minutesLeft = CompetitionDayDifference.minute
        
            let eventTitle = titleOfEvent

            print("day:", daysLeft ?? "N/A", "hour:", hoursLeft ?? "N/A", "minute:", minutesLeft ?? "N/A")

            //Set countdown label text
            let timeString = "\(daysLeft ?? 0) Days, \(hoursLeft ?? 0) Hours, \(minutesLeft ?? 0) Minutes"
            print(timeString)
        
            print("titleOfEvent is: \(eventTitle)")
        
        //This is where we would need to save the event
        
        
        }
}
