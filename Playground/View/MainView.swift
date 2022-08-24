//
//  ViewController.swift
//  Playground
//
//  Created by Chris Smith on 09/08/2022.
//

import UIKit

class MainView: UIViewController {
    
  //MARK: - Constants and variables
  //Holds reference to the Functions class
    let functions = Functions()
    
    
  //MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var colourTxtField: UITextField!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Change the way the datePicker looks
        datePicker.preferredDatePickerStyle = .inline
        
      //Each time a new date and time is selected from the picker, the handler function will run
        datePicker.addTarget(self, action: #selector(MainView.handler(sender:)), for: UIControl.Event.valueChanged)
    }
    
    
  //MARK: - Functions for this class
    
      //This will run each time a new date/time is selected from the picker
        @objc func handler(sender: UIDatePicker) {
            
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            
        //Get the specific elements, such as: hour, min, month, year, day from the datePicker
            let dateComponents = Calendar.current.dateComponents([.hour, .minute, .month, .year, .day], from: datePicker.date)
            let hour = dateComponents.hour
            let minute = dateComponents.minute
            let month = dateComponents.month
            let year = dateComponents.year
            let day = dateComponents.day
            
         //Print the selected datePicker components
            print("hour: \(hour!), min: \(minute!), month \(month!), year: \(year!), day: \(day!)" )
            
         //Now, let's work out the difference between today's date and the date selected in datePicker
         //When this function runs, the time difference will be printed
            functions.updateTimeDifference(compYear: year!, compMonth: month!, compDay: day!, compHour: hour!, compMin: minute!)
    }

    
  //MARK: - IBActions
    
    @IBAction func changeBackgroundTapped(_ sender: Any) {
        
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
    }
}

