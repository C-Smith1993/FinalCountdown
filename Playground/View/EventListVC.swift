//
//  EventListVC.swift
//  Playground
//
//  Created by Chris Smith on 25/08/2022.
//

import UIKit
import CoreData

class EventListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
  //Used to store variables of different data types
    struct MyEvent{
        var name : String
        var days : Int64
        var mins : Int64
        var hours : Int64
    }
     
    
  //Access to the Functions class
    let functions = Functions()
    
    
  //Array of events from CoreData
    var eventsArray : [MyEvent] = []
    
    
  //Allows us to make changes to managed objects (Event). We can track, update and save changes
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
  //The selected info in date picker before time difference worked out
    var selectedDatePickerInfo : EventStructs.DateTimeSelected?
    
    
    
//MARK: - IBOutlets
    
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Set this class as the tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
      //Load the saved data using CoreData
        fetchData()
        
      //This will listen for a newly created event in the other datePicker VC
      //Once there is a new update, the catchNotification function will run
      //We want to obtain the year, month, day, hour, minute
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "eventDetails"), object: nil, queue: nil, using:catchNotification)
    }
    
    
    
    func fetchData(){
        print("Fetching Data...")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject]{
                let eventName = data.value(forKey: "name") as! String
                let days = data.value(forKey: "days") as! Int64
                let minutes = data.value(forKey: "minutes") as! Int64
                let hours = data.value(forKey: "hours") as! Int64
                
                //Add each event to the array
                eventsArray.append(MyEvent.init(name: eventName, days: days, mins: minutes, hours: hours))
                
                //Reload the tableView with the new data
                tableView.reloadData()
            }
            
            }catch{
                print("Fetching data failed")
            }
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
                                functions.updateTimeDifference(titleOfEvent: event, compYear: year, compMonth: month, compDay: day, compHour: hr, compMin: min)
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
        titleLabel.text = eventsArray[indexPath.row].name
        
        //days is tag 2
        let timeRemainingLabel = eventCell.viewWithTag(2) as! UILabel
        timeRemainingLabel.text = ("\(eventsArray[indexPath.row].days)  days: \(eventsArray[indexPath.row].hours)  hours: \(eventsArray[indexPath.row].mins)  minutes")
        
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
}
