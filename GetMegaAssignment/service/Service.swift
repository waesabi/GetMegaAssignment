//
//  Service.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

protocol Service: AnyObject {
    func fetch<T: Codable>(endpoint: Endpoint, type: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}
