//
//  Chanson publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension Chanson: Publiable {
    
    public var sortie: String {
        let txtParties = parties.map { $0.sortie }.joined(separator: "\n\n")
        return titre + "\n" + auteurs + "\n\n" + txtParties
    }
    
    public var sortieAvecStyle: NSAttributedString {
        let partiesAvecStyle = parties.map { $0.sortieAvecStyle }
            .joint(separateur: "\n\n".avecStyle)
        
        return titre.avecStyle.avecTaille(16)
            .joint(avec: "\n\n".avecStyle)
            .joint(avec: auteurs.avecStyle.avecTaille(12))
            .joint(avec: "\n\n".avecStyle)
            .joint(avec: partiesAvecStyle)
    }

}
