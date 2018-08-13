//
//  CardCollectionViewCell.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!

    var card: Card?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private(set) var shown: Bool = false

    func showCard(show: Bool, animted: Bool) {
        frontImageView.isHidden = false
        backImageView.isHidden = false
        shown = show

        if animted {
            if show {
                UIView.transition(from: frontImageView,
                    to: backImageView,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { (finished: Bool) -> () in
                    })
            } else {
                UIView.transition(from: backImageView,
                    to: frontImageView,
                    duration: 0.5,
                    options: [.transitionFlipFromLeft, .showHideTransitionViews],
                    completion: { (finished: Bool) -> () in
                    })
            }
        } else {
            if show {
                bringSubview(toFront: backImageView)
                frontImageView.isHidden = true
            } else {
                bringSubview(toFront: frontImageView)
                backImageView.isHidden = true
            }
        }
    }

}
