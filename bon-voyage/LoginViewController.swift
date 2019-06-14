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
        let loginManager = FirebaseAuthManager()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
//        loginManager.signIn(email: email, pass: password) {[weak self] (success, error) in
        loginManager.signIn(email: "aaa@aaa.com", pass: "000000") {[weak self] (success, error) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                message = "User was sucessfully logged in."
            } else {
                message = error!.localizedDescription
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            self.navigationItem.rightBarButtonItem?.isEnabled = true

//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tripsTableViewController") as! TripsTableViewController
//            UIApplication.shared.keyWindow?.rootViewController?.present(newViewController, animated: true, completion: nil)

        }
//        self.navigationController?.pushViewController(TripsTableViewController(), animated: true)

        
//        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] user, error in
//            guard let strongSelf = self else { return }
//            if user == nil {
//                let alert = UIAlertController(title: "Auth failure", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
//
//                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
//                    //Cancel Action
//                }))
//                self?.present(alert, animated: true, completion: nil)
//            } else {
//                self?.navigationController!.popViewController(animated: true)
//            }
//        }
    }
    
}
