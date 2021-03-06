//
//  Endpoint.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
        
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
