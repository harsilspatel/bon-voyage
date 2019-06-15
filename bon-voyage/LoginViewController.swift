//
//  LoginViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 21/4/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var launchButton: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        storyboard?.instantiateViewController(withIdentifier: "tripsTableViewController")
//        self.navigationController?.pushViewController(TripsTableViewController(), animated: true)


        self.signin(8)
//        Auth.auth().signInAnonymously(completion: nil)

    }
    
    @IBAction func signin(_ sender: Any) {
        var message = ""
//        let email = emailTextField.text!
//        let password = passwordTextField.text!
        let email = "abc@xyz.com"
        let password = "000000"
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                message = error.localizedDescription
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            } else {
                let db = AppCommons.sharedInstance.database
                db.collection("users").document(email).getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()!
                        AppCommons.sharedInstance.userName = data["name"] as? String
                        print("SIGNED IN!!!")
                        print(AppCommons.sharedInstance.userName)
                    } else {
                        print("Document does not exist")
                    }
                }

                
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
//        self.performSegue(withIdentifier: "launchAppSegue", sender: self)
    }
}
    

