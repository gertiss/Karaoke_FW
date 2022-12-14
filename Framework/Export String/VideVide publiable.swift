//
//  VideVide publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation


extension VideVide: Publiable {
    
    public var sortie: String {
        "\(DemiSoupir().sortie) \(DemiSoupir().sortie)"
    }
    
    public var sortieAvecStyle: NSAttributedString {
        DemiSoupir().sortieAvecStyle
            .joint(avec: " ".avecStyle)
            .joint(avec: DemiSoupir().sortieAvecStyle)
    }
}
