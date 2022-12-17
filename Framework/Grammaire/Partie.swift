//
//  Partie.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 28/11/2022.
//

import Foundation
import Lecteur

public struct Partie: AvecLecteur {
    public let nom: String
    public let lignes: [Ligne]
    
    public init(nom: String = "", lignes: [Ligne]) {
        self.nom = nom
        self.lignes = lignes
    }
    
    public var description: String {
        "Partie(nom: \(nom), lignes: \(lignes.map { $0.description }.joined (separator: "\n" )))"
    }
    
    /// Provisoire : ne tient pas compte du nom, qui est vide
    public static let lecteur = Ligne.lecteur.listeNonVideAvecSeparateur("\n")
        .mapValeur { lignes in
            Partie(nom: "", lignes: lignes)
        }
    
    public var sourceRelisible: String {
        lignes.map { $0.sourceRelisible }.joined(separator: "\n")
    }
    
}

public extension Partie {
    var indexDerniereLigne: Int { lignes.count - 1 }

    func laLigne(curseur: Curseur) -> Ligne? {
        let index = curseur.ligne
        guard index >= 0 && index < lignes.count else {
            return nil
        }
        return lignes[index]
    }
    
    func laMesure(curseur: Curseur) -> Mesure? {
        laLigne(curseur: curseur)?.laMesure(curseur: curseur)
    }
    
    func leTemps(curseur: Curseur) -> Temps? {
        laMesure(curseur: curseur)?.leTemps(curseur: curseur)
    }
    
    /// Vérifie que le curseur désigne bien une ligne, une mesure, un temps existant dans la chanson self.
    /// Ne s'occupe ps de partie.
    func estValide(curseur: Curseur) -> Bool {
        laLigne(curseur: curseur) != nil && laMesure(curseur: curseur) != nil && leTemps(curseur: curseur) != nil
    }
    
    var nbMesures: Int {
        lignes.reduce(0) { cumul, ligne in
            cumul + ligne.nbMesures
        }
    }
    
    var nbTemps: Int {
        lignes.reduce(0) { cumul, ligne in
            cumul + ligne.nbTemps
        }
    }
    
    var nbLignes: Int {
        lignes.count
    }
    

}

