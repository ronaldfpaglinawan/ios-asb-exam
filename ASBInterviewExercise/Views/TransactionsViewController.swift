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
    private var viewModel = TransactionViewModel()
    private var clientData: [Transaction]?
    
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        viewModel.consumeAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Custom Methods
    private func setupBinders() {
        viewModel.finalData.bind { [weak self] _ in
            self?.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.clientTableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource
extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.decodedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath) as? customTableViewCell else {
            return UITableViewCell()
        }
        
        var tempDate = Date()
        // convert String to Date format
        if let convertedDate = String.stringToDate(dateString: viewModel.decodedData[indexPath.row].transactionDate) {
            tempDate = convertedDate
        }
        // convert Date to String format
        let stringDate = String.dateToString(date: tempDate)
        
        cell.dateLabel.text = stringDate
        cell.summaryLabel.text = viewModel.decodedData[indexPath.row].summary
        
        
        if viewModel.decodedData[indexPath.row].debit != 0.0 {
            cell.debitCreditLabel.text = String(format: "+$%.2f", viewModel.decodedData[indexPath.row].debit)
            cell.debitCreditLabel.textColor = .systemGreen
        } else {
            cell.debitCreditLabel.text = String(format: "-$%.2f", viewModel.decodedData[indexPath.row].credit)
            cell.debitCreditLabel.textColor = .systemRed
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTransaction = viewModel.decodedData[indexPath.row]
            
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            viewController.detailInfo = selectedTransaction
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
