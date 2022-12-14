//
//  Encadrement.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 03/12/2022.
//

import Foundation
import Lecteur
import RegexBuilder

public enum Encadrement: UnEncadrement {
    case parentheses
    case crochets
    case accolades
    
    public var ouvrante: String {
        switch self {
        case .parentheses: return "("
        case .crochets: return "["
        case .accolades: return "{"
        }
    }
    
    public var fermante: String {
        switch self {
        case .parentheses: return ")"
        case .crochets: return "]"
        case .accolades: return "}"
        }
    }
    
}

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
    static let regex = RX.unOuPlusieursReturn
    
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


