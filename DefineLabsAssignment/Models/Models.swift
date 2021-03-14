//
//  Models.swift
//  DefineLabsAssignment
//
//  Created by Rishikesh Yadav on 3/14/21.
//

import Foundation

struct SearchResponse: Decodable {
    let meta: MetaData
    let response: ResponseData
}

struct ResponseData: Decodable {
    let venues: [Venue]
    let confident: Bool
}

struct Venue: Decodable {
    let id: String
    let name: String
    var isVenueSaved = false
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
 }

struct MetaData: Decodable {
    let code: Int
    let requestId: String
}
