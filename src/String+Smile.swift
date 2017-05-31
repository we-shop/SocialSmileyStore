//
//  String+Smile.swift
//  SocialSmileyStore
//
//  Created by Hais Deakin on 31/05/2017.
//
//

import Foundation
import Smile

typealias Emoji = String

extension String {
    
    var isEmoji: Bool {
        return Smile.isEmoji(character: self)
    }
    
    static func listEmoji() -> [Emoji] {
        return Smile.list() // List all emojis
            .filter { $0.isEmoji } // Weird bug where Smile returns chars that are just symbols
    }
    
}
