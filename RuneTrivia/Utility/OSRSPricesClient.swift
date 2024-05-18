//
//  OSRSPricesClient.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import Foundation
import UIKit

class OSRSPricesClient {
    
    private let latestPricesURL = "https://prices.runescape.wiki/api/v1/osrs/latest"
    private let pricesMappingURL = "https://prices.runescape.wiki/api/v1/osrs/mapping"
    private let imagesURL = "https://oldschool.runescape.wiki/images/"
    
    func fetchLatestPrices(completion: @escaping (Result<LatestPriceData, Error>) -> Void) async {
        
        guard let url = URL(string: latestPricesURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let res = try decoder.decode(LatestPrice.self, from: data)
            completion(.success(res.data))
            
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchPricesMapping(completion: @escaping(Result<PriceMappingData, Error>) -> Void) async {
        
        guard let url = URL(string: pricesMappingURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let dataArray = try decoder.decode([PriceMappingObject].self, from: data)
            var dataDict = PriceMappingData()
            dataArray.forEach { obj in
                dataDict[obj.id] = obj
            }
            completion(.success(dataDict))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchImage(at fileName: String, completion: @escaping(Result<UIImage, Error>) -> Void) async {
        // Check to see if the file name is valid
        guard fileName.suffix(4) == ".png" else {
            completion(.failure(NSError(domain: "Invalid image type: \(fileName)", code: 1)))
            return }
        
        let name = fileName.replacingOccurrences(of: " ", with: "_")
        
        guard let url = URL(string: imagesURL + name) else {
            completion(.failure(NSError(domain: "Invalid URL: \(imagesURL + name)", code: 0)))
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)!
            completion(.success(image))
        } catch {
            completion(.failure(error))
        }
    }
}
