//
//  NetworkManager.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var cache = NSCache<NSString, NSData>()
    private init() {}
    
    func get<T: Decodable>(url: URL, skipDecoding: Bool = false, completion: @escaping (Result<T, SSError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unableToComplete))
                return
            }
            if skipDecoding, let rawData = data as? T {
                completion(.success(rawData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
}
