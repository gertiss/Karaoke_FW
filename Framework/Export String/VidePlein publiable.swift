//
//  VidePlein publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension VidePlein: Publiable {
    
    public var sortie: String {
        "\(DemiSoupir().sortie) \(Croche(syllabe: syllabe2).sortie)"
    }
    
    public var sortieAvecStyle: NSAttributedString {
        DemiSoupir().sortieAvecStyle
            .joint(avec: " ".avecStyle)
            .joint(avec: Croche(syllabe: syllabe2).sortieAvecStyle)
    }
}
