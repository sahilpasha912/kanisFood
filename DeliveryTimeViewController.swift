//
//  DeliveryTimeViewController.swift
//  Foodomia
//
//  Created by Rao Mudassar on 07/01/2020.
//  Copyright © 2020 dinosoftlabs. All rights reserved.
//

import UIKit
import DatePickerDialog

class DeliveryTimeViewController: UIViewController {
    
    
    @IBOutlet weak var txt_date: UILabel!
    
    @IBOutlet weak var txt_time: UILabel!
    
    var myDate:String! = ""
    var myTime:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(StaticData.singleton.deliveryDate != ""){
            
            let fullName = StaticData.singleton.deliveryDate
            let fullNameArr = fullName?.split{$0 == " "}.map(String.init)
            // or simply:
            // let fullNameArr = fullName.characters.split{" "}.map(String.init)

          
            
            // Last
            self.txt_date.text = "Delivery Date    "+fullNameArr![0]
            self.txt_time.text = "Delivery Time    "+fullNameArr![1]
            
            self.myDate = fullNameArr![0]
            self.myTime = fullNameArr![1]
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false;
        
    }
    
    
    @IBAction func openDatePicker(_ sender: Any) {
        
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode:.date) {
                  (backDate) -> Void in
                  if let dt = backDate{
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "dd-MM-yyyy"
                      
                      self.txt_date.text = "Delivery Date    "+dateFormatter.string(from:dt)
                     self.myDate = dateFormatter.string(from:dt)
                      
                  }
              }
        
    }
    
    @IBAction func openTimePicker(_ sender: Any) {
        
        DatePickerDialog().show("Select Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode:.time) {
            (backDate) -> Void in
            if let dt = backDate{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                
                self.txt_time.text = "Delivery Time    "+dateFormatter.string(from:dt)
                self.myTime = dateFormatter.string(from:dt)
                
            }
        }
    }
    
    
    @IBAction func Continue(_ sender: Any) {
        
        if(txt_date.text == "Delivery Date   dd-MM-yyyy"){
            
            self.alertModule(title:"Error", msg:"Please select delivery date.")
        }else if(txt_time.text == "Delivery Time    00:00"){
            
            self.alertModule(title:"Error", msg:"Please select delivery time.")
        }else{
        StaticData.singleton.deliveryDate = self.myDate+" "+self.myTime
            navigationController?.popViewController(animated: true)
        }
    }
    
    func alertModule(title:String,msg:String){
           
           let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
           
           let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: {(alert : UIAlertAction!) in
               alertController.dismiss(animated: true, completion: nil)
           })
     
           alertController.addAction(alertAction)
           
           present(alertController, animated: true, completion: nil)
           
       }
    
    


}
