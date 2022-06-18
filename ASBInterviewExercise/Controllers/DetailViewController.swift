//
//  DetailViewController.swift
//  ASBInterviewExercise
//
//  Created by Ronald Fornis Paglinawan on 17/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var debitCreditLabel: UILabel!
    
    
    // MARK: - Properties
    var detailInfo: Client?
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateLabels()
    }
    
    
    // MARK: - Custom Methods
    func populateLabels() {
        guard let details = detailInfo else {return}
        print("details: \(details)")
        
        var tempDate = Date()
        // convert String to Date format
        if let convertedDate = String.stringToDate(dateString: details.transactionDate) {
            tempDate = convertedDate
        }
        // convert Date to String format
        let stringDate = String.dateToString(date: tempDate)
        
        
        dateLabel.text = stringDate
        summaryLabel.text = details.summary
        
        if details.debit != 0.0 {
            debitCreditLabel.text = String(format: "+$%.2f", details.debit)
            debitCreditLabel.textColor = .systemGreen
        } else {
            debitCreditLabel.text = String(format: "-$%.2f", details.credit)
            debitCreditLabel.textColor = .systemRed
        }
    }
}
