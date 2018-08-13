//
//  Card.swift
//  colorMagic
//
//  Created by Anthony on 6/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

class Card: CustomStringConvertible {

    var id: NSUUID = NSUUID.init()
    var shown: Bool = false
    var image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    init(card: Card) {
        self.id = card.id.copy() as! NSUUID
        self.shown = card.shown
        self.image = card.image.copy() as! UIImage
    }

    var description: String {
        return "\(id.uuidString)"
    }

    func equals(card: Card) -> Bool {
        return card.id.isEqual(id)
    }
}
