//
//  SaisieChanson.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 17/12/2022.
//

import Foundation
import Lecteur

public extension Chanson {
    
    static let lecteurDeSaisie:  Lecteur<Chanson> = Chanson.lecteur.enIgnorantEncadrement(prefixe: EspacesOuTabsOuReturns.lecteur, suffixe: EspacesOuTabsOuReturns.lecteur)

}
