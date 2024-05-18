//
//  PriceMapping.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import Foundation

// API Endpoint: https://prices.runescape.wiki/api/v1/osrs/mapping
struct PriceMapping: Codable {
    var data: PriceMappingData
}

typealias PriceMappingData = [Int: PriceMappingObject]

struct PriceMappingObject: Codable {
    var examine: String
    var id: Int
    var members: Bool
    var lowalch: Int?
    var limit: Int?
    var highalch: Int?
    var icon: String
    var name: String
}


