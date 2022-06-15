//
//  RestClient.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import Foundation

class RestClient {
    
    var session: URLSession
    
    init() {
        //2
        session = URLSession(configuration: .default)
    }
    
    func apiRequest(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        //3
        let sessionTask = session.dataTask(with: request, completionHandler: completionHandler)
        
        //4
        sessionTask.resume()
    }
    
    func cancelAllTasks() {
        session.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }
}
