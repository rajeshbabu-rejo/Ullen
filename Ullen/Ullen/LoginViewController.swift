//
//  LoginViewController.swift
//  Ullen
//
//  Created by Rajesh Babu on 18/02/23.
//
import LocalAuthentication
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Unlock with Face ID", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Please authorize with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
                        self?.present(alert,animated: true)
                    return
                }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "cMain")
                    vc.modalPresentationStyle = .overFullScreen
                    self?.present(vc, animated: true)
                }

            }
        }
        else {
            let alert = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
            present(alert,animated: true)
        }
    }
    @IBAction func login(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func validateFields(){
        if email.text?.isEmpty == true {
            print("No text in email")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password")
            return
        }
        login()
    }
    func login() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, err in
            guard let strongSelf = self else{ return }
            if let err = err {
                print(err.localizedDescription)
            }
        }
        self.checkUserInfo()
    }
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "cMain")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}
