//
//  EventListVC.swift
//  Playground
//
//  Created by Chris Smith on 25/08/2022.
//

import UIKit

class EventListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventTitle = ""
    
    struct Event{
        var title: String
        var days: String
    }
    
    var eventsArray = [Event]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let event1 = Event(title: "Holiday", days: "234")
        let event2 = Event(title: "Birthday", days: "189")
        
        eventsArray.append(event1)
        eventsArray.append(event2)
        
        print(eventsArray)
        
        tableView.reloadData()
        
      //This will listen for a newly created event in the other VC
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "eventDetails"), object: nil, queue: nil, using:catchNotification)
    }
    
    
  //This will run once a notification has been received from the other VC
    func catchNotification(notification:Notification) -> Void {
      guard let event = notification.userInfo!["eventTitle"] else { return }

      print("The event has been passed: \(event)")
    }

    
    //tableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        //title is tag 1
        let titleLabel = eventCell.viewWithTag(1) as! UILabel
        titleLabel.text = eventsArray[indexPath.row].title
        
        //days is tag 2
        let daysLabel = eventCell.viewWithTag(2) as! UILabel
        daysLabel.text = eventsArray[indexPath.row].days
        
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
}
