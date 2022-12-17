//
//  Texte.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 07/12/2022.
//

import Foundation
import Lecteur

public struct Texte: AvecLecteurRegex, AvecLecteurInstance  {
    
    
    public var string: String
    public static let regex = RX.texteEnLigne
    
    public init(string: String) {
        self.string = string
    }
    
    public init(_ sourceRelisible: String) {
        self.string = sourceRelisible
    }
}

public extension Texte  {

    static func valeur(_ sortie: Substring) -> Texte {
        Texte(string: String(sortie).elague)
    }
    
    var sourceRelisible: String {
        string
    }
    
    var description: String {
        "Texte(string: \"\(string)\")"
    }
    
}


