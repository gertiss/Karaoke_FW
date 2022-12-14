//
//  Temps publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

extension Temps: Publiable {
    
    public var sortie: String {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.sortie
        case .pleinVide(let pleinVide):
            return pleinVide.sortie
        case .videPlein(let videPlein):
            return videPlein.sortie
        case .videVide(let videVide):
            return videVide.sortie
        }
    }
    
    public var sortieAvecStyle: NSAttributedString {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.sortieAvecStyle
        case .pleinVide(let pleinVide):
            return pleinVide.sortieAvecStyle
        case .videPlein(let videPlein):
            return videPlein.sortieAvecStyle
        case .videVide(let videVide):
            return videVide.sortieAvecStyle
        }
    }
}
