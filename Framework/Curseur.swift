//
//  Curseur.swift
//  TimeAfterTime
//
//  Created by Gérard Tisseau on 02/12/2022.
//

import Foundation

/// Indique une position dans une chanson :
/// quelle partie dans la chanson
/// quelle ligne dans cette partie
/// quelle mesure dans cette ligne
/// quel temps dans cette mesure
/// C'est la chanson elle-même qui vérifie si un curseur donné est valide, le curseur ne s'en occupe pas.
public struct Curseur: Equatable {
    public var partie: Int
    public var ligne: Int
    public var mesure: Int
    public var temps: Int
    
    public init(partie: Int = 0, ligne: Int = 0, mesure: Int = 0, temps: Int = 0) {
        self.partie = partie
        self.ligne = ligne
        self.mesure = mesure
        self.temps = temps
        
    }
}

extension Curseur: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        "Curseur(partie: \(partie), ligne: \(ligne), mesure: \(mesure), temps: \(temps))"
    }
    
    public var debugDescription: String {
        "Curseur(\(partie), \(ligne), \(mesure), \(temps))"
    }

}
