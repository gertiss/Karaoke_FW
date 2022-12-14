//
//  DemiSoupir.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

/// Un silence qui dure une croche
public struct DemiSoupir: Publiable {
}

public extension DemiSoupir  {
    var sortie: String {
        "-"
    }
    
    var sortieAvecStyle: NSAttributedString {
        sortie.avecStyle
            .avecTaille(14)
            .avecCouleur(.lightGray)
    }
    
    
}
