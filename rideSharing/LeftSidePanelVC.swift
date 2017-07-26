//
//  LeftSidePanelVC.swift
//  rideSharing
//
//  Created by Aivars Meijers on 22.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    
    let appDelegate = AppDelegate()
    let currentUserId = Auth.auth().currentUser?.uid

    @IBOutlet weak var pickupSwitch: UISwitch!
    @IBOutlet weak var pickupStatusLabel: UILabel!
    @IBOutlet weak var profileImage: RoundImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var LogInOutButton: UIButton!
    @IBOutlet weak var accountTypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        hideUserDetails()

        observeAppUser()
        
        if Auth.auth().currentUser != nil{
            emailLabel.text = Auth.auth().currentUser?.email
            LogInOutButton.setTitle("Logout", for: .normal)
        }
        
        
    }
    
    func hideUserDetails() {
        pickupSwitch.isEnabled = false
        pickupSwitch.isHidden = true
        pickupStatusLabel.isHidden = true
        accountTypeLabel.text = ""
        profileImage.isHidden = true
        emailLabel.text = ""
        LogInOutButton.setTitle("Sigl Up / Login", for: .normal)

    }
    
    func observeAppUser (){
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountTypeLabel.text = "Passenger"
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountTypeLabel.text = "Driver"
                        
                        //fetch driver pickupMode status and set switch
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupSwitch.isOn = switchStatus
                        self.pickupSwitch.isHidden = false
                        self.pickupSwitch.isEnabled = true
                        self.pickupStatusLabel.isHidden = false
                        
                    }
                }
            }
        })
    }
    
    
    @IBAction func SignUpLoginButtonPresed(_ sender: Any) {
        if Auth.auth().currentUser == nil{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        } else {
            do{
                try Auth.auth().signOut()
                hideUserDetails()
            } catch (let error){
                print(error)
            }
        }
        
    }
    
    @IBAction func onSwitchButton(_ sender: UISwitch) {
        if pickupSwitch.isOn {
            pickupStatusLabel.text = "Pickup Mode Enabled"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled":true])
        } else {
            pickupStatusLabel.text = "Pickup Mode Disabled"
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled":false])
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
