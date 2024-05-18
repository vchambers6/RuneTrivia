//
//  HomeGameCollectionViewCell.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    var gameImageView: UIImageView!
    
    var gameLabelView: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gameImageView = UIImageView()
        gameImageView.contentMode = .scaleAspectFit
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gameImageView)
        
        gameLabelView = UILabel()
        gameLabelView.textAlignment = .center
        gameLabelView.translatesAutoresizingMaskIntoConstraints = false
        gameLabelView.numberOfLines = 2
//        gameLabelView.setContentHuggingPriority(UILayoutPriority(252.0), for: .vertical)
        contentView.addSubview(gameLabelView)
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            gameImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height*0.8),
            gameImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            gameLabelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gameLabelView.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 5),
            gameLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gameLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            gameLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])
        
//        gameLabelView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with game: Game) {
        gameImageView.image = game.image
        gameLabelView.text = game.title
    }
}
