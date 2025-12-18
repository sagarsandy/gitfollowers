//
//  AvatarImageView.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import UIKit

class AvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let cachedData = NetworkManager.shared.cache.object(forKey: cacheKey) {
            image = UIImage(data: cachedData as Data)
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.shared
            .get(url: url, skipDecoding: true) { (result: Result<Data, SSError>) in
            switch result {
            case .success(let data):
                NetworkManager.shared.cache.setObject(data as NSData, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                return
            }
        }
    }

}
