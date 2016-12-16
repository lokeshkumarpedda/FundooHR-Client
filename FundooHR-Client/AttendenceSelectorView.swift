//
//  AttendenceSelectorView.swift
//  FundooHR-Client
//
//  Created by BridgeLabz on 16/12/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class AttendenceSelectorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func attendanceMarked(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func companyHoliday(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func leave(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func noAttendance(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
