//
//  Game.swift
//  RuneTrivia
//
//  Created by Vanessa Chambers on 5/17/24.
//

import UIKit

struct Game {
    let title: String
    let image: UIImage
    let information: String
}

let games: [Game] = [
    Game(title: "EntrepreRUNEur", image: UIImage(named: "EntrepRUNEur")!, information: #"EntrepreRUNEur is kind of like the RuneScape version of the price is right. In this game, you will be presented with an item that is traded on the Grand Exchange in RuneScape. You collectively have thirty seconds to guess what you think the current Grand Exchange price of the item presented. The person with the guess closest to the actual price gets a point. If multuple people are equally closest to the actual price, then all of those people will receive a point. At the end of 10 rounds, the person with the highest number of points wins."#),
    Game(title: "Gielinor Sachs Analyst", image: UIImage(named: "EntrepRUNEur")!, information: #"In this game, you will be a gielinor Sachs Analyst; you will be given a chart of the price of an item traded on the Grand Exchange over the past 90 days, and based on the data provided, you will have 1 minute to guess what item the chart describes. All players who guess correctly will receive one point. At the end of 10 rounds, the person with the highest number of points wins."#)
]
