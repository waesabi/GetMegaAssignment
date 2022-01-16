//
//  TrendingService.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation



class TrendingService: Service {
    
    func fetch<T>(endpoint: Endpoint, type: T.Type, completion: @escaping (Result<T, APIError>) -> Void) where T: Codable {
        
        if !NetworkMonitor.shared.isReachable {
            completion(.failure(.custom(message: "Please check your network connection")))
            return            
        }
        
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        print("url: \(url.absoluteString)")
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.invalidURL))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.dataNotFound))
                }
                return
            }
            do {
                let decodedResp = try JSONDecoder().decode(type, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResp))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.custom(message: error.localizedDescription)))
                }
            }
        }
        dataTask.resume()
    }
}
