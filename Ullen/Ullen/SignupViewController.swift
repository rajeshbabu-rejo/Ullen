//
//  SignupViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 18/02/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
class SignupViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signup(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("No text in email")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password")
            return
        }
        signup()
    }
    
    @IBAction func login(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func signup() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("error \(error?.localizedDescription)")
                return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "main")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
