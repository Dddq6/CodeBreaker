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
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing = Peg.clear
    
    enum Kind: Equatable {
        case master
        case guess
        case attempts([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempts(let matches): return matches
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        //init all result is nomatch
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        //copy that and do something
        var pegsToMatch = otherCode.pegs

        //reversed()cuz it promised not chaos of index
        for index in pegs.indices.reversed() {
            //count always 1 more than index cuz it comes from 0
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                //let results matches the pegs
                results[index] = .exact
                //remove the candidiate
                pegsToMatch.remove(at: index)
            }
        }

        for index in pegs.indices {
            //find the other inexact
            if results[index] != .exact {
                //find the first index of the the same color of pegs
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }

        return results
    }
}

