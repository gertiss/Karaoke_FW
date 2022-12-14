//
//  Encadrement.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 03/12/2022.
//

import Foundation
import Lecteur
import RegexBuilder


struct AccoladeOuvrante: AvecLecteurRegex {
    static func valeur(_ sortie: (Substring, Self)) -> AccoladeOuvrante {
        AccoladeOuvrante()
    }
    
    static let regex: Regex<(Substring, Self)> = Regex {
        Capture {
            RX.espacesOuTabsOuReturns
            "{"
            RX.espacesOuTabsOuReturns
       } transform: {_ in
            Self()
        }
    }
        
    typealias SortieRegex = (Substring, Self)
    
    var sourceRelisible: String {
        "{"
    }
    
    var description: String {
        "AccoladeOuvrante()"
    }
    
    
}

struct AccoladeFermante: AvecLecteurRegex {
    static func valeur(_ sortie: (Substring, AccoladeFermante)) -> AccoladeFermante {
        Self()
    }
    
    /// Une accolade ouvrante obligatoire éventuellement entourée d'espacesOuTabsOuReturns
    static let regex: Regex<(Substring, Self)> = Regex {
        Capture {
            RX.espacesOuTabsOuReturns
            "}"
            RX.espacesOuTabsOuReturns
        } transform: {_ in
            Self()
        }
    }
        
    typealias SortieRegex = (Substring, Self)
    
    var sourceRelisible: String {
        "}"
    }
    
    var description: String {
        "AccoladeFermante()"
    }
    
}

struct UnOuPlusieursReturn: AvecLecteurRegex {
    
    typealias SortieRegex = Substring
    static let regex = RX.unOuPlusieursReturns
    
    static func valeur(_ sortie: Substring) -> UnOuPlusieursReturn {
        Self()
    }

    var sourceRelisible: String {
        "\n"
    }
    
    var description: String {
        "UnOuPlusieursReturn()"
    }
    
}



