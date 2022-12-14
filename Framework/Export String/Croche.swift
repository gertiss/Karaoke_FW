//
//  Croche.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

/// Une syllabe qui dure une croche
public struct Croche: Publiable {
    public var syllabe: String
}

public extension Croche  {
    var sortie: String {
        syllabe
    }
    
    var sortieAvecStyle: NSAttributedString {
        sortie.avecStyle
            .avecTaille(14)
    }
}
