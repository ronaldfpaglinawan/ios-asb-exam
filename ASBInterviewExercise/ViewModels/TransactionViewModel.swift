//
//  TransactionViewModel.swift
//  ASBInterviewExercise
//
//  Created by Ronald Fornis Paglinawan on 18/06/22.
//

import Foundation

final class TransactionViewModel {
    // MARK: - Properties
    let urlString = "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json"
    var decodedData: [Transaction] = []
    var finalData: ObservableObject<[Transaction]?> = ObservableObject(nil)
    
    
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
            decodedData = try decoder.decode([Transaction].self, from: clientData)
            
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
        
        getFinalData()
    }
    
    func getFinalData() {
        self.finalData.value = decodedData
    }
}
