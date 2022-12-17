//
//  Mesure.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 28/11/2022.
//

import Foundation
import Lecteur

public struct Mesure: AvecLecteur {
    
    public let temps: [Temps]
    
    public init(temps: [Temps] = []) {
        self.temps = temps
    }
    
    public var description: String {
        "Mesure(temps: \(temps.map { $0.description }.joined(separator: ", ")))"
    }
    
    public static let lecteur = Temps.lecteur.listeNonVideAvecSeparateur(",")
        .mapValeur { liste in
            Mesure(temps: liste)
        }
        
    public var sourceRelisible: String {
        temps.map { $0.sourceRelisible }.joined(separator: ", ")
    }

}

public extension Mesure {
    var indexDernierTemps: Int { temps.count - 1 }
    
    func leTemps(curseur: Curseur) -> Temps? {
        let index = curseur.temps
        guard index >= 0 && index < temps.count else {
            return nil
        }
        return temps[index]
    }
    
    /// Vérifie que le curseur désigne bien un temps existant dans la mesure self.
    /// Ne s'occupe pas de partie, ligne, mesure
    func estValide(curseur: Curseur) -> Bool {
         leTemps(curseur: curseur) != nil
    }
    
    var nbTemps: Int {
        temps.count
    }
}

