//
//  Mesure publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation


extension Mesure: Publiable {
    
    public var sortie: String {
        temps.map { $0.sortie }.joined(separator: "   ")
    }
    
    public var sortieAvecStyle: NSAttributedString {
        temps.map { $0.sortieAvecStyle }
            .joint(separateur: "    ".avecStyle)
    }
    
}
