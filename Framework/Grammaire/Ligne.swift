//
//  Ligne.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 28/11/2022.
//

import Foundation
import Lecteur

public struct Ligne: Equatable, CustomStringConvertible, AvecLecteur {
    
    public let mesures: [Mesure]
    
    public init(mesures: [Mesure]) {
        self.mesures = mesures
    }

    public static let lecteur = Mesure.lecteur.listeNonVideAvecSeparateur("|")
        .mapValeur { mesures in
            Ligne(mesures: mesures)
        }
    
    public var sourceRelisible: String {
        mesures.map { $0.sourceRelisible }.joined(separator: "| ")
    }
    
    
    public var description: String {
        "Ligne(mesures: \(mesures.map { $0.description }.joined(separator: "| ")))"
    }
}

public extension Ligne {
  
    var indexDerniereMesure: Int { mesures.count - 1 }

    func laMesure(curseur: Curseur) -> Mesure? {
        let index = curseur.mesure
        guard index >= 0 && index < mesures.count else {
            return nil
        }
        return mesures[index]

    }
    
    func leTemps(curseur: Curseur) -> Temps? {
        laMesure(curseur: curseur)?.leTemps(curseur: curseur)
    }
    
    /// Vérifie que le curseur désigne bien une mesure, un temps existant dans la ligne self.
    /// Ne s'occupe pas de partie, ligne
    func estValide(curseur: Curseur) -> Bool {
         laMesure(curseur: curseur) != nil && leTemps(curseur: curseur) != nil
    }

    var nbMesures: Int {
        mesures.count
    }
    
    var nbTemps: Int {
        mesures.reduce(0) { cumul, mesure in
            cumul + mesure.nbTemps
        }
    }

}


