//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by 董浩天 on 2026/9/26.
//

import SwiftUI

typealias Peg = Color //sematic naming

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)//default and it's gonna have some arguement
    var guess: Code = Code(kind: .guess)
//    var attempts: [Code] = [Code]() //it could be crushed if there is nothing
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
    

//    func changeGuessPeg(at: index = Int) {
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            //%:if it's the last one like (3+1=4)%4=0 not 4 cuz it'll gonna crash
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            //?? means nil-coalescing operator n Code.missing means fallback value
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}

struct Code {
    var kind: Kind
    /*var pegs: [Peg] = [.green, .red, .yellow, .blue]*/ //four Pegs made a Code
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    //static let missing: Peg = .clear this is the tc write
    static let missing = Peg.clear
    //Which is the this types?(which is the "Kind" of Code is it?
    enum Kind: Equatable {
        case master//Got to hide this Pegs
        case guess//editibal Code cuz im guessing
        case attempts([Match])//non-editibal Code, but i can see the previous attempts ive made
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempts(let matches): return matches
        default: return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs

        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }

        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }

        return results
    }
}

//struct Peg {
//    var color: Color
//}->typealias


