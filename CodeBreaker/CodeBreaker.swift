//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/26.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempts(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}

//adds new functionality to an existing type
extension Peg {
    static let missing = Color.clear
}

struct Code {
    var kind: Kind
//    var pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4)
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)

    
    static let missingPeg = Peg.clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempts([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempts(let matches): return matches
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        //        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        //functional programming function
        //"I'm transforming every index into a Match, and map builds the result array for me."
        
//        let exactMatches = pegs.indices.reversed().map() { index in
        let backwardsMatches = pegs.indices.reversed().map() { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        
        //"I'm going through the array and manually modifying results."
        //        for index in pegs.indices.reversed() {
        //            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
        //                results[index] = .exact
        //                pegsToMatch.remove(at: index)
        //            }
        //        }
        
        let exactMatches = Array(backwardsMatches.reversed())
        
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
        
        //        for index in pegs.indices {
        //            if results[index] != .exact {
        //                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
        //                    results[index] = .inexact
        //                    pegsToMatch.remove(at: matchIndex)
        //                }
        //            }
        //        }
        //
        //        return results
    }
}

