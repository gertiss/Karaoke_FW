//
//  PleinPlein pubiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation


extension PleinPlein: Publiable {
    
    public var sortie: String {
        "\(Croche(syllabe: syllabe1).sortie) \(Croche(syllabe: syllabe2).sortie)"
    }
    
    public var sortieAvecStyle: NSAttributedString {
        Croche(syllabe: syllabe1).sortieAvecStyle
            .joint(avec: " ".avecStyle)
            .joint(avec: Croche(syllabe: syllabe2).sortieAvecStyle)
    }
}
