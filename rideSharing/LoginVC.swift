//
//  LoginVC.swift
//  rideSharing
//
//  Created by Aivars Meijers on 23.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.bindtoKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func cancelButtonPresed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
