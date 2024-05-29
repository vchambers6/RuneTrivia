//
//  HomeCollectionViewController+DataSource.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/28/24.
//

import UIKit

extension HomeCollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Game.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Game.ID>
    
    func updateSnapshot(reloading ids: [Game.ID] = []) {
        var snapshot = Snapshot()
        /// add group 0 and reloaded ids to the snapshot
        snapshot.appendSections([0])
        snapshot.appendItems(games.map { $0.id })
        /// reload the items at ids in the snapshot
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    func cellRegistrationHandler(cell: GameCollectionViewCell, indexPath: IndexPath, id: Game.ID) {
        let game = game(withId: id)
        
        cell.gameImageView = UIImageView(image: game.image)
        var label = UILabel()
        label.text = game.title
        cell.gameLabelView = label
        
    
    }
    
    func game(withId id: Game.ID) -> Game {
        let index = games.indexOfGame(withId: id)
        
        return games[index]
    }
}
