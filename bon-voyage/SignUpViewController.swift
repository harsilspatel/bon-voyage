//
//  SignUpViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 30/5/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signup(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
        signUpManager.createUser(email: email.text!, password: password.text!) {[weak self] (success, error) in
            guard let `self` = self else { return }
            var message: String = ""
            print(success)
            if (success) {
                message = "User was sucessfully created."
            } else {
                message = error!.localizedDescription
            }
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }

//        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
//            if authResult == nil {
//                let alert = UIAlertController(title: "Delete?", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
//
//                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
//                    //Cancel Action
//                }))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
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
