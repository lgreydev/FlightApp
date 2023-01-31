//
//  Card.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-01-30.
//

import Foundation

struct Card: Identifiable {
    var id: UUID = .init()
    var cardImage: String
}

var sampleCards: [Card] = [
    .init(cardImage: "card1"),
    .init(cardImage: "card2"),
    .init(cardImage: "card3"),
    .init(cardImage: "card4"),
    .init(cardImage: "card5"),
    .init(cardImage: "card6"),
    .init(cardImage: "card7"),
    .init(cardImage: "card8"),
    .init(cardImage: "card9")
]
