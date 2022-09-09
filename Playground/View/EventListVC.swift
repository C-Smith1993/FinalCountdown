//
//  EventListVC.swift
//  Playground
//
//  Created by Chris Smith on 25/08/2022.
//

import UIKit

class EventListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let functions = Functions()
    
    //Create a date model
    struct EventModel{
        var eventTitle : String
        var year : Int
        var month : Int
        var day : Int
        var hour : Int
        var minute : Int
    }
    
    //The selected info in date picker before time difference worked out
    var selectedDatePickerInfo : EventModel?
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //This will listen for a newly created event in the other datePicker VC
      //Once there is a new update, the catchNotification function will run
      //We want to obtain the year, month, day, hour, minute
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "eventDetails"), object: nil, queue: nil, using:catchNotification)
    }
    
    
  //This will run once a notification has been received from the other VC
    func catchNotification(notification:Notification) -> Void {
        if let event = notification.userInfo!["eventTitle"] as? String{
            if let hr = notification.userInfo!["hour"] as? Int{
                if let min = notification.userInfo!["min"] as? Int{
                    if let month = notification.userInfo!["month"] as? Int{
                        if let year = notification.userInfo!["year"] as? Int{
                            if let day = notification.userInfo!["day"] as? Int{
                                
                                print("These were selected using the datePicker: eventTitle: \(event), hour: \(hr), minute: \(min), month: \(month), year: \(year), day: \(day)")
                                
                                //Now work out the difference between the current date and selected date
                                functions.updateTimeDifference(compYear: year, compMonth: month, compDay: day, compHour: hr, compMin: min)
                            }
                         }
                      }
                    }
                 }
               }
             } 

    
    //tableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        //title is tag 1
        let titleLabel = eventCell.viewWithTag(1) as! UILabel
        titleLabel.text = ""
        
        //days is tag 2
        let daysLabel = eventCell.viewWithTag(2) as! UILabel
        daysLabel.text = ""
        
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
