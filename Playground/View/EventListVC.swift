//
//  EventListVC.swift
//  Playground
//
//  Created by Chris Smith on 25/08/2022.
//

import UIKit

class EventListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        //Create some temp events
        let event1 = Event(title: "Holiday", days: "1090")
        let event2 = Event(title: "Brad's birthday", days: "209")
        
        eventsArray.append(event1)
        eventsArray.append(event2)
        
        tableView.reloadData()
    }
    
    //tableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        //title is tag 1
        //days is tag 2
        
        let titleLabel = eventCell.viewWithTag(1) as! UILabel
        titleLabel.text = eventsArray[indexPath.row].title
        
        let daysLabel = eventCell.viewWithTag(2) as! UILabel
        daysLabel.text = eventsArray[indexPath.row].days
        
        return eventCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
