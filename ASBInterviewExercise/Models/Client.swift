//
//  Client.swift
//  ASBInterviewExercise
//
//  Created by Ronald Fornis Paglinawan on 16/06/22.
//

import Foundation

struct Client: Codable {
    let id: Int
    let transactionDate: String
    let summary: String
    let debit: Double
    let credit: Double
}
