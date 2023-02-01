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
    .init(cardImage: "credit_card_001"),
    .init(cardImage: "credit_card_002"),
    .init(cardImage: "credit_card_003"),
    .init(cardImage: "credit_card_004"),
    .init(cardImage: "credit_card_005"),
    .init(cardImage: "credit_card_006"),
]
