//
//  File.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import Foundation
import UIKit

struct Strings {
    static let HighScores = "High Scores"
    static let HyperLink = "https://www.AntmanTech"

    struct Home {
        static let RestartBtn = "Restart"
        static let ACTitle = "Really want to restart???"
        static let ACMsg = "Reminder: Your current score will be ignored"
        static let ACAConfirmTitle = "Confirm"
        static let ACACancelTitle = "Carry On, I can do it "
        
    }

    struct ScoreBoard {
        static let NibName = "ScoreTableViewCell"
        static let BackgroundViewText = "Play Game to Climb on the Score Board"
    }
    struct FinishView {
        static let NibName = "FinishView"
    }
}

struct Numeric {
    static let CardRatio: CGFloat = 190 / 152
    static let NoOfItemsInRow: CGFloat = 4
    static let NoOfItemsInTotal: CGFloat = 16
}

struct Identifier {
    static let CardCell = "CardCellId"
    static let ScoreCell = "ScoreCellId"
    static let Scoreboard = "colorMajctRecord"
}

struct Keys {
    static let kName = "kName"
    static let kScores = "kScores"
}



struct ViewTitles {
    static let kScoreBoard = "Score Board"
    static let kHome = "Yeah!!"
}

