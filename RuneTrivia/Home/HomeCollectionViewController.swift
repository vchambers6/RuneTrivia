//
//  HomeCollectionViewController.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/28/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {
    
    var games: [Game] = Game.games
    var dataSource: DataSource!
    
    init() {
        /// UICollectionViewCompositionalLayout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // We are saying the group takes up 70% of width and 80% of height of section
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // you can scroll and stop at any item
        let collecitonLayout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: collecitonLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("we should use the other initializer has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = .white
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
    }
}
