//
//  blockStreamAPI.swift
//  final-exam-swift
//
//  Created by ankur kaul on 07/12/2019.
//  Copyright © 2019 Langara. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
}

enum HTTPMethod: String {
    case get = "GET"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    
    init(method: HTTPMethod, path: String){
        self.method = method
        self.path = path
    }
}

struct APIClient {
    
    typealias APIClientCompletion = (HTTPURLResponse?, Data?, APIError?) -> Void
    
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://www.blockstream.info/")!
    
    func request(_ request: APIRequest, _ completion: @escaping APIClientCompletion) {
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(nil, nil, .invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers?.forEach({ urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) })
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, .requestFailed)
                return
            }
            completion(httpResponse, data, nil)
        }
        task.resume()
    }
}
