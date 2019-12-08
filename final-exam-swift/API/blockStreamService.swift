//
//  blockStreamService.swift
//  final-exam-swift
//
//  Created by ankur kaul on 07/12/2019.
//  Copyright © 2019 Langara. All rights reserved.
//

import Foundation

protocol BlockStreamDelegate: class {
    func requestFailed(with error: APIError)
    func searchCompleted(with blocks: Blocks)
}

final class BlockStreamService {
    public weak var delegate: BlockStreamDelegate?
    private var client = APIClient()
    
    init(delegate: BlockStreamDelegate){
        self.delegate = delegate
    }
    
    func allBlocks(searchHeight: String) {
        let request = APIRequest(method: .get, path: "api/block-height/\(searchHeight)")
        
        request.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
        
        client.request(request) { (response, data, error) in
            guard error == nil else {
                self.delegate?.requestFailed(with: error!)
                return
            }
            
            if let data = data {
                if let blocksResponse = try? JSONDecoder().decode(Blocks.self, from: data) {
                    self.delegate?.searchCompleted(with: blocksResponse)
                }
            } else {
                self.delegate?.requestFailed(with: .requestFailed)
            }
        }
    }
}
//    func allBlocks(searchCity: String, searchCountry: String) {
//        let request = APIRequest(method: .get, path: "forecast")
//
//        request.queryItems = [
//            URLQueryItem(name: "q", value: "\(searchCity),\(searchCountry)"),
//            URLQueryItem(name: "units", value: "metric")
//        ]
//
//        request.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
//
//        client.request(request) { (response, data, error) in
//            guard error == nil else {
//                self.delegate?.requestFailed(with: error!)
//                return
//            }
//
//            if let data = data {
//                if let weatherForecast = try? JSONDecoder().decode(Forecast.self, from: data) {
//                    self.delegate?.searchCompleted(with: weatherForecast)
//                }
//            } else {
//                self.delegate?.requestFailed(with: .requestFailed)
//            }
//        }
//    }
