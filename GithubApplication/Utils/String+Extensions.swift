//
//  String+Extensions.swift
//  GithubApplication
//
//  Created by Janus Jordan on 2/4/23.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
