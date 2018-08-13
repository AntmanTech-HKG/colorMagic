//
//  ScoreBoard.swift
//  colorMagic
//
//  Created by Anthony on 6/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import Foundation

class Score: NSObject, NSCoding {
    var name: String?
    var scores: Int! = 0

    init(name: String, scores: Int) {
        self.name = name
        self.scores = scores
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(scores!, forKey: Keys.kScores)
        aCoder.encode(name, forKey: Keys.kName)
    }

    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: Keys.kName) as! String
        let scores = aDecoder.decodeInteger(forKey: Keys.kScores)

        self.init(name: name, scores: scores)
    }

}

class ScoreBoardManager: NSObject {
    // singleton
    private static var mInstance: ScoreBoardManager?
    static func sharedInstance() -> ScoreBoardManager {
        if mInstance == nil {
            mInstance = ScoreBoardManager()
        }
        return mInstance!
    }

    let standard = UserDefaults.standard

    func clean() {
        standard.removeObject(forKey: Identifier.Scoreboard)
    }

//    High scores must be stored and persist as long as the user does not uninstall the app or clear the app's stored data.
    /*
     High scores database may be implemented using the device's internal database. Network-based high scores will be considered as an extra feature with the exception of a pure web app.
     */
    
    func save(score: Score) {
        if var existingBoard = get() {
            existingBoard.append(score)
            existingBoard.sort(by: { $0.scores > $1.scores })
            if existingBoard.count > 10 {
                existingBoard.removeLast()
            }

            let encodedData = NSKeyedArchiver.archivedData(withRootObject: existingBoard)
//            print("\(encodedData)")
            standard.set(encodedData, forKey: Identifier.Scoreboard)
        } else {
            let newBoard = [score]
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: newBoard)
//            print("\(encodedData)")
            standard.set(encodedData, forKey: Identifier.Scoreboard)
        }
    }

    func get() -> [Score]? {
        if let decoded = standard.object(forKey: Identifier.Scoreboard) as? NSData {
            let unarchivedStocks = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Score]
            return unarchivedStocks
        } else {
            return nil
        }
    }
}
