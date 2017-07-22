//
//  CenterVCDelegete.swift
//  rideSharing
//
//  Created by Aivars Meijers on 22.07.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
    
}


