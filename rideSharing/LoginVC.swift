//
//  LoginVC.swift
//  rideSharing
//
//  Created by Aivars Meijers on 23.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var segmentedControler: UISegmentedControl!
    @IBOutlet weak var emailField: RoundedCornerTextField!
    @IBOutlet weak var passwordField: RoundedCornerTextField!
    @IBOutlet weak var logInButton: RoundedShadowButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.bindtoKeyboard()
        emailField.delegate = self
        passwordField.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func cancelButtonPresed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPresed(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil {
            logInButton.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    // if user exixts log him in
                    if error == nil{
                        if let user = user {
                            if self.segmentedControler.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.providerID] as [String: Any]
                                DataService.instance.screateFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider": user.providerID,"userIsDriver":true, "isPickupModeEnabled":false, "driverIsOnTrip":false, "DriverIsActivated":false] as [String: Any]
                                DataService.instance.screateFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                
                            }
                        }
                        print("Email user autentificated sucessfully with Firebase")
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        
                        if let errorCode = AuthErrorCode (rawValue: error!._code){
                            switch errorCode {
                            case .invalidEmail : print("Email invalid. Please try again")
                            case .emailAlreadyInUse : print("This email is already in use. Please try again")
                            case .wrongPassword : print("Wrong password. Plese try again")
                            default: print("An unexpected error occured. Please try again")
                                
                                
                            }
                        }
                        
                        // if user does not exits, create new user
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            // handle autentification errors and display messages
                            if error != nil {
                                if let errorCode = AuthErrorCode (rawValue: error!._code){
                                    switch errorCode {
                                    case .invalidEmail : print("Email invalid. Please try again")
                                    case .emailAlreadyInUse : print("This email is already in use. Please try again")
                                    case .wrongPassword : print("Wrong password. Plese try again")
                                    default: print("An unexpected error occured. Please try again")
                                    }
                                }
                            } else {
                                if let user = user {
                                    if self.segmentedControler.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.providerID] as [String: Any]
                                        DataService.instance.screateFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider": user.providerID,"userIsDriver":true, "isPickupModeEnabled":false, "driverIsOnTrip":false, "DriverIsActivated":false] as [String: Any]
                                        DataService.instance.screateFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                print("New user created sucessfully with Firebase")
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                            
                        })
                    }
                })
            }
        }
    }
    
}
