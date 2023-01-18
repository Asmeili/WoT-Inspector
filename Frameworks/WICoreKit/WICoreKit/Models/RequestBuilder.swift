//
//  RequestBuilder.swift
//  WICoreKit
//
//  Created by Michael Artes on 03.12.22.
//

import Foundation

public class RequestBuilder {
    private var urlComponents: URLComponents
    private var httpHeaders: [String: String] = [:]
    
    public init(url: URL, resolvingAgainstBaseURL: Bool) {
        urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL)!
    }
    
    public init(string: String) {
        urlComponents = URLComponents(string: string)!
    }
    
    public func build() -> URLRequest {
        guard let url = urlComponents.url else {
            fatalError("Fatal: Failed to build URL from \(String(describing: urlComponents.string))")
        }
        
        var request = URLRequest(url: url)
        if request.allHTTPHeaderFields == nil {
            request.allHTTPHeaderFields = httpHeaders
        } else {
            request.allHTTPHeaderFields = request.allHTTPHeaderFields!.merging(httpHeaders) { _, new in new }
        }
        return request
    }
    
    public func addQueryItem(name: String, value: String) -> Self {
        let queryItem = URLQueryItem(name: name, value: value)
        return addQueryItem(queryItem)
    }

    public func addQueryItem(_ queryItem: URLQueryItem) -> Self {
        if urlComponents.queryItems != nil {
            urlComponents.queryItems!.append(queryItem)
        } else {
            urlComponents.queryItems = [queryItem]
        }
        return self
    }
    
    public func setHeader(name: String, value: String) -> Self {
        httpHeaders[name] = value
        return self
    }
}
