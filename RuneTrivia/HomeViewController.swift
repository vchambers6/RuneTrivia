//
//  HomeViewController.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

class HomeViewController: UIViewController {

    
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 300)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        self.view.backgroundColor = .blue
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "GameCollectionViewCell")
        
        
        self.view.addSubview(collectionView)
        self.title = "RuneTrivia"
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Game.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        cell.setup(with: Game.games[indexPath.row])
        return cell
    }
}



extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = Game.games[indexPath.row]
        print(game.title)
        
        let informationViewController = InformationViewController()
        informationViewController.game = game
        
        self.navigationController?.pushViewController(informationViewController, animated: true)
    }
}
