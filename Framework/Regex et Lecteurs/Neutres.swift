//
//  Neutres.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 16/12/2022.
//

import Foundation
import Lecteur


struct EspacesOuTabs: AvecLecteurRegex {
    
    static let regex = RX.espacesOuTabs
    
    static func valeur(_ sortie: Substring) -> EspacesOuTabs {
        Self()
    }
    
    var sourceRelisible: String {
        ""
    }
    
    var description: String {
        "EspacesOuTabs()"
    }
}

struct EspacesOuTabsOuReturns: AvecLecteurRegex {
    
    static let regex = RX.espacesOuTabsOuReturns
    
    static func valeur(_ sortie: Substring) -> EspacesOuTabsOuReturns {
        Self()
    }
    
    var sourceRelisible: String {
        ""
    }
    
    var description: String {
        "EspacesOuTabsOuReturn()"
    }

}
