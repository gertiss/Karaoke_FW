//
//  Ligne publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension Ligne: Publiable {
    
    public var sortie: String {
        mesures.map { $0.sortie }.joined(separator: " | ")
    }
    
    public var sortieAvecStyle: NSAttributedString {
        mesures.map { $0.sortieAvecStyle }
            .joint(separateur: " | ".avecStyle.avecTaille(16).avecCouleur(.lightGray))
    }

}
