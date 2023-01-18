//
//  ApiService.swift
//  WICoreKit
//
//  Created by Michael Artes on 03.12.22.
//

import Combine

public class ApiService {
    private let applicationId: String
    private let session: URLSession
    public var authenticationJar = CurrentValueSubject<AuthenticationJar?, Never>(nil)
    public init(applicationId: String, session: URLSession) {
        self.applicationId = applicationId
        self.session = session
    }
    
    public func request<T: Decodable>(from requestBuilder: RequestBuilder, into: T.Type) -> AnyPublisher<ApiResponse<T>, Error> {
        let request = requestBuilder
            .addQueryItem(name: "application_id", value: applicationId)
        
        if let accessToken = authenticationJar.value?.accessToken {
            _ = request.addQueryItem(name: "access_token", value: accessToken)
        }
        
        return session.json(from: request.build(), into: ApiResponse<T>.self)
    }
}
