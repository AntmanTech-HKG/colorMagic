//
//  ColorMagic.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

/*
 The goal of this work sample is to construct a sample memory game called ”Colour Memory”. The game board consists of a 4x4 grid with 8 pairs of color cards.
 The game starts initially with all cards facing down. The player is to then flip two cards each round, trying to find a match. If the flipped pair is a match, the player receives two (2) points, and the cards may be removed from the game board. Otherwise, the cards are turned face down again and the player loses one (1) point. This continues until all pairs have been found.
 After the game is finished, the player should be prompted to input his name. The player’s name and the score would then be stored in a database, and the player should be notified of his score and the current rankings. Also, the player can restart the current game and the score will be reset.
 */

import UIKit

protocol ColorMagicDelegate {
    func colorMagicDidStart(_ game: ColorMagic)
    func colorMagicDidEnd(_ score: Int)
    func colorMagicShowCard(_ card: Card)
    func colorMagicHideCards(_ cards: [Card])
    func colorMagicUpdateScore(_ score: Int)

}

class ColorMagic {

    let cardImages: [UIImage] = [
        UIImage(named: "colour1")!,
        UIImage(named: "colour2")!,
        UIImage(named: "colour3")!,
        UIImage(named: "colour4")!,
        UIImage(named: "colour5")!,
        UIImage(named: "colour6")!,
        UIImage(named: "colour7")!,
        UIImage(named: "colour8")!
    ]

    var cards: [Card] = [Card]()
    var delegate: ColorMagicDelegate?
    var isPlaying: Bool = false
    var score: Int = 0

    func newGame() {
        cards = generateCards()
        score = 0
        isPlaying = true
        delegate?.colorMagicDidStart(self)
    }

    func resetGame() {
        isPlaying = false
        cards.removeAll()
        selectedCard.removeAll()
    }

    func finish() {
        resetGame()
        delegate?.colorMagicDidEnd(score)
    }

    private var selectedCard: [Card] = [Card]()

    func didSelect(index: Int?) {
        if let index = index {
            let card = cards[index]

            delegate?.colorMagicShowCard(card)

            if selectedCard.count % 2 != 0 {
                // already got one card in the selected array
                // so here we will compare it
                if let unpairedCard = selectedCard.last {
                    if card.equals(card: unpairedCard) {
                        // bingo
                        score = score + 2
                        delegate?.colorMagicUpdateScore(score)
                        selectedCard.append(card)

                    } else {
                        // incorrect
                        score = score - 1
                        delegate?.colorMagicUpdateScore(score)
                        selectedCard.removeLast()
                        // should hide card
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.delegate?.colorMagicHideCards([card, unpairedCard])
                        }
                    }
                }
            } else {
                // not new selection before
                selectedCard.append(card)
            }

            if selectedCard.count == cards.count {
                // finish game here
                finish()
            }
        }
    }

    private func generateCards() -> [Card] {
        var cards = [Card]()
        for i in 0...cardImages.count - 1 {
            let card = Card.init(image: cardImages[i])
            cards.append(contentsOf: [card, Card.init(card: card)])
        }
        cards.shuffle()
        return cards
    }

    func getIndexFromCard(_ card: Card) -> Int {
        for index in 0...cards.count - 1 {
            if card === cards[index] {
                return index
            }
        }
        return -1
    }
}
