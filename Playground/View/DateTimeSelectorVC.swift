//
//  ViewController.swift
//  Playground
//
//  Created by Chris Smith on 09/08/2022.
//

import UIKit

class DateTimeSelectorVC: UIViewController {
    
    
    
//MARK: - Constants, variables & structs
  //Holds reference to the Functions class
    let functions = Functions()
    
  //Hold a reference to the EventListVC
    let eventListVC = EventListVC()
    
  //Hold these here, so they can be passed through to the EventListVC
    var eventTitle = String()
    var hour = Int()
    var minute = Int()
    var month = Int()
    var year = Int()
    var day = Int()
    
    
    
  //MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Change the way the datePicker looks
        datePicker.preferredDatePickerStyle = .inline
        
      //Each time a new date and time is selected from the picker, the handler function will run
        datePicker.addTarget(self, action: #selector(DateTimeSelectorVC.handler(sender:)), for: UIControl.Event.valueChanged)
    }
    
    
  //MARK: - Functions for this class
    
      //This will run each time a new date/time is selected from the picker
        @objc func handler(sender: UIDatePicker) {
            
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            
        //Get the specific elements, such as: hour, min, month, year, day from the datePicker, then update the variables. These can be passed through to the EventListVC later on.
            let dateComponents = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)
            hour = dateComponents.hour!
            minute = dateComponents.minute!
            month = dateComponents.month!
            year = dateComponents.year!
            day = dateComponents.day!
            
            eventTitle = eventTxtField.text!
    }

    
    
  //MARK: - IBActions
    
    @IBAction func createEventBtnTapped(_ sender: Any) {
        
     // Pass Data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eventDetails"), object: nil, userInfo: ["eventTitle": eventTitle, "hour" : hour, "min" : minute, "month" : month, "year" : year, "day" : day])
        
        dismiss(animated: true, completion: nil)
    }
    
      /* Use this inside a function if you'd like to change the background colour
       
       let colourTextFieldTxt = colourTxtField.text!
        
        let someColour = colourTextFieldTxt
        switch someColour {
        case "blue":
            print("Blue")
            view.backgroundColor = UIColor.blue
            
        case "green":
            print("Green")
            view.backgroundColor = UIColor.green
            
        default:
            print("An error has occurred")
            self.functions.customAlert(title: "Error", message: "Change Colour")
                    
        }
    }*/
    
}

