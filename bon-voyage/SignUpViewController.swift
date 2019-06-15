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

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func signup(_ sender: Any) {
        
        var message = ""
        
        if (name.text!.isEmpty) {
            message += "\nPlease enter the name"
        }
        
        if (email.text!.isEmpty) {
            message += "\nEnsure email is entered"
        }
        
        if (password.text!.count < 6) {
            message += "\nPlease have a password of at least 6 characters"
        }
        
        if !(message.isEmpty) {
            self.alert(message: message)
            return
        }
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {(authResult, error) in
            if let user = authResult?.user {
                message = "User was sucessfully created."
                self.db.collection("users").document(self.email.text!).setData([
                    "name": self.name.text!,
                    "trips": []
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                AppSettings.displayName = user.email
            } else {
                message = error!.localizedDescription
            }
            self.alert(message: message)
        }
        
        
//        let signUpManager = FirebaseAuthManager()
//        signUpManager.createUser(email: email.text!, password: password.text!) {[weak self] (success, error) in
//            guard let `self` = self else { return }
//            var message: String = ""
//            print(success)
//            if (success) {
//                message = "User was sucessfully created."
//
//
//            } else {
//                message = error!.localizedDescription
//            }
//            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertController, animated: true, completion: nil)
//        }
    }
    
    private func alert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
