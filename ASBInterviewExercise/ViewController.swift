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
                    let dataString = String(data: safeData, encoding: .utf8)
                    print("dataString: \(String(describing: dataString))")
                }
            }
        }
    }
}

