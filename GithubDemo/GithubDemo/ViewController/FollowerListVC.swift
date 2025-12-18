//
//  FollowerListVC.swift
//  GithubDemo
//
//  Created by Sagar on 17/12/25.
//

import UIKit

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureDataSource()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createCollectionViewFlowLayout(for: view)
        )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
//        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
    }

    private func getFollowers() {
        showLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            FollowerService.shared.fetchFollowers(for: self.username, page: 1) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(let followers):
                    self.followers.append(contentsOf: followers)
                    self.updateData()
                    print("Fetched followers: \(followers)")
                case .failure(let error):
                    self.showSSAlert(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                    print("Error fetching followers: \(error)")
                }
            }
        }
    }
    
    private func configureDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.collectionViewDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > contentHeight - height {
            getFollowers()
        }
    }
}
