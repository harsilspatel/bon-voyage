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

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        Auth.auth().signInAnonymously(completion: nil)

    }
    
    @IBAction func signin(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if user == nil {
                let alert = UIAlertController(title: "Auth failure", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
                self?.present(alert, animated: true, completion: nil)
            } else {
                strongSelf.navigationController?.pushViewController(TripsTableViewController(), animated: true)
            }
        }
    }
}
