//
//  FollowerService.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import Foundation


class FollowerService {
    static let shared = FollowerService()
    private let baseURL = "https://mocki.io/v1/"
    private init() {}
    
    func fetchFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], SSError>) -> Void) {
        let endpoint = "\(baseURL)6e1d1580-0faf-4514-bf04-980d010ce31b"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        NetworkManager.shared.get(url: url) { (result: Result<[Follower], SSError>) in
            completion(result)
        }
    }

}

