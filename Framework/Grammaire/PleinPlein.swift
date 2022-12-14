//
//  PleinPlein.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation
import Lecteur

public struct PleinPlein: AvecLecteurRegex, Hashable {
    public typealias SortieRegex = (Substring, String, String)
    public static let regex = RX.pleinPlein
    
    
    public var syllabe1: String
    public var syllabe2: String
}

public extension PleinPlein {
    
    static func valeur(_ sortie: (Substring, String, String)) -> PleinPlein {
        PleinPlein(syllabe1: sortie.1, syllabe2: sortie.2)
    }

    var sourceRelisible: String {
        "\(syllabe1) \(syllabe2)"
    }
    
    var description: String {
        "PleinPlein(syllabe1: \(syllabe1), syllabe2: \(syllabe2))"
    }
    
    
}

