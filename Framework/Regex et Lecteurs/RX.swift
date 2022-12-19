//
//  RX.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation
import RegexBuilder

public enum RX { }

// MARK: - Symboles

public extension RX {
    
    static let marqueSilenceCroche = "-"
    static let marqueSilenceNoire = "="

}

// MARK: - Classes de caractères

public extension CharacterClass {
    
    static let caractereTexteEnLigne: CharacterClass =
        .word.union(.caractereEspaceOuTab).union(.anyOf("-',;:.?!;()«»"))
    
    static let caractereSyllabe: CharacterClass =
        .word.union(.anyOf("'"))

}

// MARK: - Espacements "invisibles". Regex<Substring>
// Uniquement pour la mise en page libre du texte source
// ou pour éviter les ambiguïtés lexicales.

public extension RX {
        
    static let espacesOuTabs = Regex<Substring> {
        ZeroOrMore { CharacterClass.caractereEspaceOuTab }
    }


    static let espacesOuTabsOuReturns = Regex<Substring> {
        ZeroOrMore { CharacterClass.caractereEspaceOuTabOuReturn }
    }


    /// Un return obligatoire éventuellement suivi d'espaces ou tabs ou returns.
    /// Peut servir pour indiquer la fin d'un texteEnLigne
    static let unOuPlusieursReturns = Regex<Substring> {
        CharacterClass.newlineSequence
        ZeroOrMore { CharacterClass.caractereEspaceOuTabOuReturn }
    }

}

// MARK: - Séquences "visibles". Regex<Substring>

public extension RX {
    
    /// Un texte "littéraire" pouvant tenir sur une ligne (titre, auteur, commentaire)
    /// Autorisés : .word, espace, tab, tiret, apostrophe, ponctuations, parenthèses, guillemets français, guillemets anglais.
    /// Doit commencer par un caractère ni espace ni tab.
    /// Les parenthèses et guillemets français doivent être bien équilibrés.
    /// Les guillemets anglais doivent être en nombre pair.
    /// Exclus et pouvant indiquer la fin : return, accolades, crochets, autres symboles.
    static let texteEnLigne = Regex<Substring> {
        CharacterClass.caractereTexteEnLigne.subtracting(.caractereEspaceOuTab)
        ZeroOrMore { CharacterClass.caractereTexteEnLigne }
    }

    static let syllabe = Regex<Substring> {
        OneOrMore { CharacterClass.caractereSyllabe }
    }
    
}

// MARK: - Différentes formes d'un Temps

public extension RX {
    
    /// Deux syllabes séparées par au moins un espace.
    /// Consomme les espaces ou tabs qui suivent.
    /// Ne compile pas directement en PleinPlein.
    static let pleinPlein = Regex<(Substring, String, String)> {
        Capture {
            syllabe
        } transform: { String($0) }
        espacesOuTabs
        " "
        espacesOuTabs
        Capture {
            syllabe
        } transform: { String($0) }
        espacesOuTabs
    }
   
    /// Une seule syllabe.
    /// Consomme les espaces ou tabs qui suivent.
    /// Compile directement en PleinVide
    static let pleinVide = Regex<(Substring, PleinVide)> {
        Capture {
            syllabe
        } transform: { PleinVide(syllabe1: String($0)) }
        espacesOuTabs
    }
    
    /// Une marque de demi-soupir suivie d'une syllabe.
    /// Consomme les espaces ou tabs qui suivent.
    /// Compile directement en VidePlein
    static let videPlein = Regex<(Substring, VidePlein)> {
        marqueSilenceCroche
        espacesOuTabs
        Capture {
            syllabe
        } transform: { VidePlein(syllabe2: String($0)) }
        espacesOuTabs
    }
    
    /// Une marque de soupir suivie d'une syllabe.
    /// Consomme les espaces ou tabs qui suivent.
    /// Compile directement en VideVide
    static let videVide = Regex<(Substring, VideVide)> {
        Capture {
            marqueSilenceNoire
        } transform: { s in
            VideVide()
        }
        espacesOuTabs
    }

}

