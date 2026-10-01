//
//  Code.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/29.
//


import SwiftUI

struct Code {
    var kind: Kind
//    var pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4)
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)

    
    static let missingPeg = Peg.clear
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempts([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        //IT"LL BE CRUSHED CUZ AI and you just teb
//        for index in pegChoices.indices {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    mutating func reset() {
        pegs = Array(repeating: .missing, count: 4)
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempts(let matches): return matches
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs

        let backwardsMatches = pegs.indices.reversed().map() { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
                
        let exactMatches = Array(backwardsMatches.reversed())
        
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
        
    }
}
