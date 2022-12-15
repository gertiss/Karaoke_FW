//
//  PleinVide.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation

import Foundation
import Lecteur

public struct PleinVide: AvecLecteurRegex, Hashable {
    
    public let syllabe1: String
    
    public init(syllabe1: String) {
        self.syllabe1 = syllabe1
    }
    
    public typealias SortieRegex = (Substring, PleinVide)
    public static let regex = RX.pleinVide
}

public extension PleinVide {
    
    static func valeur(_ sortie: (Substring, PleinVide)) -> PleinVide {
        sortie.1
    }
    
    var sourceRelisible: String {
        "\(syllabe1)"
    }
    
    var description: String {
        "PleinVide(syllabe1: \(syllabe1))"
    }
    
}

