//
//  LatestPrice.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import Foundation

// API Endpoint: https://prices.runescape.wiki/api/v1/osrs/latest
struct LatestPrice: Codable {
    var data: LatestPriceData
}
typealias LatestPriceData = [String: LatestPriceObject]

struct LatestPriceObject: Codable {
    var high: Int?
    var highTime: Int?
    var low: Int?
    var lowTime: Int?
}
