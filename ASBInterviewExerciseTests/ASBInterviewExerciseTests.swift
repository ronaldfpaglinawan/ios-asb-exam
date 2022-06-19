//
//  ASBInterviewExerciseTests.swift
//  ASBInterviewExerciseTests
//
//  Created by ASB on 29/07/21.
//

import XCTest
@testable import ASBInterviewExercise

class ASBInterviewExerciseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTransaction() {
        let transaction = Transaction(id: 0, transactionDate: "2022-02-22T22:22:22", summary: "Won from Lotto!", debit: 999999.99, credit: 0)
        
        XCTAssertEqual(transaction.debit, 999999.99)
    }
    
    func testTransactionViewModel() {
        let transactionViewModel = TransactionViewModel()
        
        XCTAssertEqual(transactionViewModel.urlString, "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json")
    }
    
    func testDateToString() {
        let sampleDateString = "2022-02-22T22:22:22"
        
        var tempDate = Date()
        // convert String to Date format
        if let convertedDate = String.stringToDate(dateString: sampleDateString) {
            tempDate = convertedDate
        }
        // convert Date to String format
        let stringDate = String.dateToString(date: tempDate)
        
        XCTAssertEqual(stringDate, "Feb 22, 2022 10:22:22 PM")
    }
}
