//
//  VideVide.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation
import Lecteur

public struct VideVide: AvecLecteurRegex, Hashable {
    
    // Aucune variable stockée
    
    public init() { }
    
    public static let regex = RX.videVide
    
    public static func valeur(_ sortie: (Substring, VideVide)) -> VideVide {
        sortie.1
    }
    
    public typealias SortieRegex = (Substring, VideVide)
    
}

public extension VideVide {
    
    var sourceRelisible: String {
        RX.marqueSilenceNoire
    }
    
    var description: String {
        "VideVide()"
    }
    
    
}

