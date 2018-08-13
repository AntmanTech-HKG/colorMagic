//
//  Extensions+Array.swift
//  colorMagic
//
//  Created by Anthony on 5/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import Foundation

extension Array {
    
    //Randomizes array elements
    mutating func shuffle() {
        for _ in 1...self.count {
            self.sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
