//
//  VidePlein.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 29/11/2022.
//

import Foundation
import Lecteur

public struct VidePlein: AvecLecteurRegex, Hashable {
    
    
    public var syllabe2: String
    
    public typealias SortieRegex = (Substring, VidePlein)
    public static let regex = RX.videPlein
    
    public init(syllabe2: String) {
        self.syllabe2 = syllabe2
    }
}
    
public extension VidePlein {
    
    static func valeur(_ sortie: (Substring, VidePlein)) -> VidePlein {
        sortie.1
    }
    
    var sourceRelisible: String {
        "\(RX.marqueSilenceCroche) \(syllabe2)"
    }
    
    var description: String {
        "VidePlein(syllabe2: \(syllabe2))"
    }
    
}

