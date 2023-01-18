//
//  URLSession+WICoreKit.swift
//  WICoreKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine
import Foundation

public enum WICoreKitNetworkError: Error {
    case notHttpResponse(response: URLResponse)
    case notHealthyStatusCode(response: HTTPURLResponse)
}

public extension URLSession {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func json<T: Decodable>(from request: URLRequest, into: T.Type) -> AnyPublisher<T, Error> {
        print("Debug: Sending url request to \(request.url!.absoluteString)")
        return dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw WICoreKitNetworkError.notHttpResponse(response: response)
                }
                
                guard httpResponse.statusCode >= 200, httpResponse.statusCode < 300 else {
                    throw WICoreKitNetworkError.notHealthyStatusCode(response: httpResponse)
                }
                
                /* if let json = try? JSONSerialization.jsonObject(with: data) {
                    print(json)
                } */
                
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
