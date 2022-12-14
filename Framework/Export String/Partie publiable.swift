//
//  Partie publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension Partie: Publiable {
    public var sortie: String {
        lignes.map { $0.sortie }.joined(separator: "\n")
    }
    
    public var sortieAvecStyle: NSAttributedString {
        lignes.map { $0.sortieAvecStyle }
            .joint(separateur: "\n".avecStyle)
    }


}

