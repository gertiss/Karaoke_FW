//
//  RX.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation
import RegexBuilder

public enum RX { }

// MARK: - Lexical

public extension CharacterClass {
    static var caractereTexte: CharacterClass {
        .word.union(.espaceOuTab).union(.anyOf("<>,?;./:=+%^$*#@&'§!-"))
    }
    
    static var caractereEspaceOuTabOuReturn: CharacterClass {
        .anyOf(" \t\n")
    }
}

public extension CharacterClass {
    static var caractereNom: CharacterClass {
        .word
    }
    
    static var caractereSyllabe: CharacterClass {
        .word.union(.anyOf("'"))
    }

    
}

// MARK: - Caractères
// Pas de capture. Type (Substring)

public extension RX {
        
    static let espacesOuTabs = Regex<Substring> {
        ZeroOrMore { CharacterClass.espaceOuTab }
    }
    

    static let espacesOuTabsOuReturns = Regex<Substring> {
        ZeroOrMore { CharacterClass.caractereEspaceOuTabOuReturn }
    }
    
    static let unOuPlusieursReturn = Regex<Substring> {
        espacesOuTabs
        CharacterClass.newlineSequence
        ZeroOrMore { CharacterClass.caractereEspaceOuTabOuReturn }
    }

    static let marqueSilenceCroche = "-"
    static let marqueSilenceNoire = "="
    
}

// MARK: - Chaines

public extension RX {
    
    static let texte = Regex<Substring> {
        .word
        ZeroOrMore { CharacterClass.caractereTexte }
    }

    static let syllabe = Regex<Substring> {
        OneOrMore { CharacterClass.caractereSyllabe }
    }
    
}

// MARK: - Mots

public extension RX {
    
    static let pleinPlein = Regex<(Substring, String, String)> {
        espacesOuTabs
        Capture {
            syllabe
        } transform: { String($0) }
        espacesOuTabs
        " " // Les deux syllabes doivent être séparées par au moins un espace
        espacesOuTabs
        Capture {
            syllabe
        } transform: { String($0) }
        espacesOuTabs
    }
   
    static let pleinVide = Regex<(Substring, PleinVide)> {
        espacesOuTabs
        Capture {
            syllabe
        } transform: { PleinVide(syllabe1: String($0)) }
        espacesOuTabs
    }
    
    static let videPlein = Regex<(Substring, VidePlein)> {
        espacesOuTabs
        marqueSilenceCroche
        espacesOuTabs
        Capture {
            syllabe
        } transform: { VidePlein(syllabe2: String($0)) }
        espacesOuTabs
    }
    
    static let videVide = Regex<(Substring, VideVide)> {
        Capture {
            espacesOuTabs
            marqueSilenceNoire
            espacesOuTabs
        } transform: { s in
            VideVide()
        }
    }

}

