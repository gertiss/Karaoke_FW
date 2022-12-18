//
//  Texte.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 07/12/2022.
//

import Foundation
import Lecteur


/// Un texte "littéraire" pouvant tenir sur une ligne (titre, auteur, commentaire)
/// Autorisés : .word, espace, tab, tiret, apostrophe, ponctuations, parenthèses, guillemets français, guillemets anglais.
/// Doit commencer par un caractère ni espace ni tab.
/// Les parenthèses et guillemets français doivent être bien équilibrés.
/// Les guillemets anglais doivent être en nombre pair.
/// Exclus et pouvant indiquer la fin : return, accolades, crochets, autres symboles.
public struct TexteEnLigne: AvecLecteurRegex, AvecLecteurInstance  {
    
    
    public var string: String
    public static let regex = RX.texteEnLigne
    
    public init(string: String) {
        self.string = string
    }
    
    public init(_ sourceRelisible: String) {
        self.string = sourceRelisible
    }
}

public extension TexteEnLigne  {

    static func valeur(_ sortie: Substring) -> TexteEnLigne {
        TexteEnLigne(string: String(sortie))
    }
    
    var sourceRelisible: String {
        string
    }
    
    var description: String {
        "Texte(string: \"\(string)\")"
    }
    
}


