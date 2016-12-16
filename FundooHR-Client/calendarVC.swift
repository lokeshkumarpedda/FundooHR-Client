//
//  calendarVC.swift
//  FundooHR-Client
//
//  Created by BridgeLabz on 14/12/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import JTAppleCalendar

class calendarVC: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    var todayDate : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.layer.cornerRadius = 8
        
        calendarView.layer.borderWidth = 3
        calendarView.layer.borderColor = UIColor(red: 180/255, green: 221/255, blue: 239/255, alpha: 1).cgColor
        //calendarView.layer.borderColor = UIColor.blue.cgColor
        calendarView?.layer.masksToBounds = true
        
        calendarView?.layer.shadowColor = UIColor.black.cgColor
        calendarView?.layer.shadowOffset = CGSize(width:0,height: 5.0)
        calendarView?.layer.shadowRadius = 5.0
        calendarView?.layer.shadowOpacity = 0.4
        
        
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView")
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        calendarView.selectDates([Date()], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: false)
        calendarView.scrollToDate(Date())
        
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension calendarVC: JTAppleCalendarViewDataSource{
    public func configureCalendar(_ calendar: JTAppleCalendar.JTAppleCalendarView) -> JTAppleCalendar.ConfigurationParameters{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 12 01")! // You can use date generated from a formatter
        let endDate = Date()
        todayDate = formatter.date(from: formatter.string(from: Date()))
                                        // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        return parameters
    }
}


extension calendarVC: JTAppleCalendarViewDelegate{
    

    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.masksToBounds = true
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        //if date == todayDate{
          //  myCustomCell.dayLabel.textColor = UIColor.red
        //}
        //else{
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
        //}
        // Setup text color
        //if cellState.dateBelongsTo == .thisMonth {
        //    myCustomCell.dayLabel.textColor = UIColor.black
        //} else {
        //    myCustomCell.dayLabel.textColor = UIColor.gray
        //}
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        
        
        
        if let customView = Bundle.main.loadNibNamed("AttendenceSelectorView", owner: self, options: nil)?.first as? AttendenceSelectorView {
            customView.center = view.center
            self.view.addSubview(customView)
        }
        
        
        // Let's make the view have rounded corners. Set corner radius to 25
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = UIColor.red
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = UIColor(colorWithHexValue: 0x6FB8D9, alpha: 1)
            } else {
                myCustomCell.dayLabel.textColor = UIColor.white
                myCustomCell.markImageView.image = nil
            }
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.layer.cornerRadius = 15
        } else {
            myCustomCell.layer.cornerRadius = 0
        }
    }
    
    //making other months dates unselectable
    func calendar(_ calendar: JTAppleCalendarView, canSelectDate date: Date, cell: JTAppleDayCellView, cellState: CellState) -> Bool {
        if cellState.dateBelongsTo == .thisMonth {
            return true
        } else {
            return false
        }
    }
    
    
    
    
}


extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
