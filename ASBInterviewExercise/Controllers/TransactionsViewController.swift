//
//  ViewController.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import UIKit

class TransactionsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var clientTableView: UITableView!
    
    
    // MARK: - Properties
    let urlString = "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json"
    var decodedData: [Client] = []
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    self.parseJSON(clientData: safeData)
                }
            }
        }
    }
    
    func parseJSON(clientData: Data) {
        let decoder = JSONDecoder()
        do {
            decodedData = try decoder.decode([Client].self, from: clientData)
            
            sortData()
        } catch {
            print(error)
        }
    }
    
    func sortData() {
        // sort items in decodedData (by transactionDate)
        decodedData = decodedData.sorted(by: {
            $0.transactionDate.compare($1.transactionDate) == .orderedDescending
        })
        
        // reload the tableView
        DispatchQueue.main.async {
            self.clientTableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource
extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath) as? customTableViewCell else {
            return UITableViewCell()
        }
        
        var tempDate = Date()
        // convert String to Date format
        if let convertedDate = String.stringToDate(dateString: decodedData[indexPath.row].transactionDate) {
            tempDate = convertedDate
        }
        // convert Date to String format
        let stringDate = String.dateToString(date: tempDate)
        
        cell.dateLabel.text = stringDate
        cell.summaryLabel.text = decodedData[indexPath.row].summary
        
        
        if decodedData[indexPath.row].debit != 0.0 {
            cell.debitCreditLabel.text = String(format: "+$%.2f", decodedData[indexPath.row].debit)
            cell.debitCreditLabel.textColor = .systemGreen
        } else {
            cell.debitCreditLabel.text = String(format: "-$%.2f", decodedData[indexPath.row].credit)
            cell.debitCreditLabel.textColor = .systemRed
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTransaction = decodedData[indexPath.row]
            
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            viewController.detailInfo = selectedTransaction
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
