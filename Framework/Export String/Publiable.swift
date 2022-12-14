//
//  Publiable.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 09/12/2022.
//

import Foundation

public protocol Publiable {
    var sortie: String { get }
    var sortieAvecStyle: NSAttributedString { get }
}

public extension Publiable {
    
    /// Par défaut, à surcharger éventuellement
    var sortieAvecStyle: NSAttributedString {
        sortie.avecStyle
    }
}
