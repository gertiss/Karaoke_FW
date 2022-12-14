//
//  PleinVide publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension PleinVide: Publiable {
    
    public var sortie: String {
        "\(Croche(syllabe: syllabe1).sortie) \(DemiSoupir().sortie)"
    }
    
    public var sortieAvecStyle: NSAttributedString {
        Croche(syllabe: syllabe1).sortieAvecStyle
            .joint(avec: " ".avecStyle)
            .joint(avec: DemiSoupir().sortieAvecStyle)
    }

}
