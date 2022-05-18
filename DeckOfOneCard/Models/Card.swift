//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Harrison Kleiman on 5/17/22.
//

import Foundation

// NEED TO BUILD OUT TOP-LEVELOBJECT TO DRILL DOWN TO CARD
struct TopLevelObject: Decodable {
    let cards: [Card]
}

// OUR MODEL
struct Card: Decodable {
    let image: URL
    let value: String
    let suit: String
}
