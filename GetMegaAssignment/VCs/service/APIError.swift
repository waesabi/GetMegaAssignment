//
//  APIError.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case dataNotFound
    case custom(message: String)
}
