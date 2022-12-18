//
//  SaisieChanson.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 17/12/2022.
//

import Foundation
import Lecteur

public struct SaisieChanson {
    public let chanson: Chanson
    
    public init(chanson: Chanson) {
        self.chanson = chanson
    }
    
    public var description: String {
        "SaisieChanson(chanson: \(chanson.description))"
    }
    
    public var sourceRelisible: String {
        chanson.sourceRelisible
    }
    
    public static let lecteur: Lecteur<SaisieChanson> =
    Chanson.lecteur.avecEncadrement(ouvrante: EspacesOuTabsOuReturns.lecteur, fermante: EspacesOuTabsOuReturns.lecteur)
        .mapValeur { chanson in
            SaisieChanson(chanson: chanson)
        }
    

}
