//
//  AddEventViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 30/5/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    var addEventDelegate: AddEventDelegate?
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addEvent(_ sender: Any) {
        let title = self.eventTitle.text!
        let duration = Int(self.duration.text!)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDate = dateFormatter.string(from: self.startDate.date)
        _ = self.addEventDelegate!.addEvent(newEvent: [
            "description": [title],
             "start": startDate,
             "duration": duration
            ])
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
