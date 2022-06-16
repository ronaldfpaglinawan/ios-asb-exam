//
//  ViewController.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var demoTextView: UITextView!
    
    
    // MARK: - Properties
    let urlString = "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json"
    var decodedData: [Client] = []
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        demoTextView.text = ""
        consumeAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Custom Methods
    func consumeAPI() {
        
        let restClient = RestClient()
        
        if let clientURL = URL(string: urlString) {
            let request = URLRequest(url: clientURL)
            
            restClient.apiRequest(request) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    self.parseJSON(clientData: safeData)
                }
            }
        }
    }
    
    func parseJSON(clientData: Data) {
        let decoder = JSONDecoder()
        do {
            decodedData = try decoder.decode([Client].self, from: clientData)
            
            // call sortData function
            sortData()
            
            //-- for testing only (displaying in textView)
            DispatchQueue.main.async {
                self.demoTextView.text = self.decodedData[0].transactionDate
            }
            //---
            
        } catch {
            print(error)
        }
    }
    
    func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    func dateToString() {
        
    }
    
    func sortData() {
        // sort items in decodedData (by transactionDate)
        decodedData = decodedData.sorted(by: {
            $0.transactionDate.compare($1.transactionDate) == .orderedDescending
        })
        
        for item in decodedData {
            //print("sorted item: \(item)")
            
            // convert the date String transactionDate to Date format
            if let convertedDate = stringToDate(dateString: item.transactionDate) {
                //print("transactionDate: \(item.transactionDate)")
                print("convertedDate: \(convertedDate)")
            }
        }
    }
}

