//
//  ApiResponse.swift
//  WICoreKit
//
//  Created by Michael Artes on 03.12.22.
//

import Foundation

public enum ApiResponseStatus: String, Codable {
    case ok
    case error
}

public struct ApiResponseError: Codable {
    public let code: Int
    public let message: String
    public let field: String?
    public let value: Int?
}

public struct ApiResponseMeta: Codable {
    public let count: Int
    public let pageTotal: Int?
    public let total: Int?
    public let limit: Int?
}

public struct ApiResponse<T: Codable>: Codable {
    public let status: ApiResponseStatus
    public let error: ApiResponseError?
    public let meta: ApiResponseMeta?
    public let data: T?
}
