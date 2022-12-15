//
//  Chanson.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 28/11/2022.
//

import Foundation
import Lecteur

public struct Chanson: Equatable, CustomStringConvertible {
    public let titre: String
    public let auteurs: String
    public let parties: [Partie]
    
    // Variables stockées pour l'efficacité, mais obtenues par calcul à l'init.
    // Une chanson a environ 300 temps.
    // Cela évite des calculs répétés en O(n^2)
    public var lesTemps: [Temps]
    public var lesCurseurs: [Curseur]
    public var nbTemps: Int
    public var lesMesures: [Mesure]
    public var nbMesures: Int

    public init(titre: String = "SansTitre", auteurs: String = "", parties: [Partie] = []) {
        self.titre = titre
        self.auteurs = auteurs
        self.parties = parties
        
        // Valeurs initiales par défaut, immédiatement calculées après
        lesTemps = []
        lesCurseurs = []
        nbTemps = 0
        lesMesures = []
        nbMesures = 0
        // Calcul des valeurs effectives
        lesTemps = tempsCalcules
        lesCurseurs = curseursCalcules
        nbTemps = lesTemps.count
        assert(nbTemps > 0, "Une chanson ne doit pas être vide")
        // Max : 4 minutes au tempo 200
        assert(nbTemps <= 4 * 200, "Le nombre de temps ne doit pas être trop grand")
        
        lesMesures = mesuresCalculees
        nbMesures = lesMesures.count
    }
    
    public var description: String {
        "Chanson(titre: \(titre), auteurs: \(auteurs), parties: \(parties.map { $0.description }.joined(separator: ", ")))"
    }
    
    /// La liste de tous les temps, dans l'ordre, obtenue par calcul
    private var tempsCalcules: [Temps] {
        var liste = [Temps]()
        for partie in parties {
            for ligne in partie.lignes {
                for mesure in ligne.mesures {
                    for temps in mesure.temps {
                        liste.append(temps)
                    }
                }
            }
        }
        return liste
    }
    
    /// La liste de tous les curseurs, dans l'ordre.
    /// Permet de parcourir séquentiellement tous les temps tout en sachant dans quelle partie, ligne, mesure, temps on est.
    /// Cette liste est couplée à la liste des temps par les indices :
    /// le curseur d'indice i désigne le temps d'indice i
    private var curseursCalcules: [Curseur] {
        var liste = [Curseur]()
        for (i, partie) in parties.enumerated() {
            for (j, ligne) in partie.lignes.enumerated() {
                for (k, mesure) in ligne.mesures.enumerated() {
                    for (l, _) in mesure.temps.enumerated() {
                        liste.append(Curseur(partie: i, ligne: j, mesure: k, temps: l))
                    }
                }
            }
        }
        return liste
    }
    
    private var mesuresCalculees: [Mesure] {
        var liste = [Mesure]()
        for partie in parties {
            for ligne in partie.lignes {
                for mesure in ligne.mesures {
                    liste.append(mesure)
                }
            }
        }
        return liste

    }
}

extension Chanson: AvecLecteur {
    
    /*
     Grammaire BNF Chanson

     chanson = enTete parties

     enTete = titre marqueFinTitre auteurs marqueFinAuteurs

     titre = caractereWord caractereTexte*
     auteurs = caractereWord caractereTexte*
     marqueFinTitre = espaceOuTab* return espaceOuTabOuReturn*
     marqueFinAuteurs = espaceOuTab* return espaceOuTabOuReturn*
     caractereTexte = caractereWord | espaceOuTab | caractereTexteSymbole
     caractereTexteSymbole = un caractère dans "<>,?;./:=+%^$*#@&'§!-"
     caractereWord = CharacterClass.word

     parties = partieEncadree+
     partieEncadree = accoladeOuvrante partie accoladeFermante
     accoladeOuvrante = espaceOuTabOuReturn* "{" espaceOuTabOuReturn*
     accoladeFermante = espaceOuTabOuReturn* "}" espaceOuTabOuReturn*

     partie = ligne (espaceOuTab* return espaceOuTab* ligne)*

     ligne = mesure (espaceOuTab* barre espaceOuTab* mesure)*

     mesure = temps (espaceOuTab* virgule espaceOuTab* temps)*

     temps = pleinPlein | pleinVide | videPlein | videVide

     pleinPlein = espaceOuTab* syllabe espaceOuTab+ syllabe espaceOuTab*
     syllabe = caractereSyllabe+
     caractereSyllabe = caractereWord | apostrophe
     pleinVide = espaceOuTab* syllabe espaceOuTab*
     videPlein = espaceOuTab* marqueSilenceCroche espaceOuTab* syllabe espaceOuTab*
     marqueSilenceCroche = "-"
     videVide = espaceOuTab* marqueSilenceNoire espaceOuTab*
     marqueSilenceNoire = "="
     */
    public static let lecteur =
    
    Texte.lecteur.avecMarqueFin(UnOuPlusieursReturn.lecteur)
        .mapErreur{ erreur in
            Erreur(message: "On attend le titre de la chanson sur une ligne", reste: erreur.reste)
        }
        .suiviDe2(
            Texte.lecteur
                .avecMarqueFin(UnOuPlusieursReturn.lecteur)
                .mapErreur{ erreur in
                    Erreur(message: "On attend les auteurs de la chanson sur une ligne", reste: erreur.reste)
                },
            Partie.lecteur
                .avecEncadrement(ouvrante: AccoladeOuvrante.lecteur, fermante: AccoladeFermante.lecteur)
                .listeNonVide()
                .mapErreur{ erreur in
                    Erreur(message: "On attend une liste de parties non vides, chacune encadrée par des accolades.\nPour cela :\n" + erreur.message, reste: erreur.reste)
                }
        )
        .mapValeur { (titre, auteurs, parties) in
            Chanson(titre: titre.string, auteurs: auteurs.string, parties: parties)
        }
    
    /// L'erreur qu'il faut afficher s'il y a un reste après lireTout
    public static func erreurSiReste(_ reste: String) -> Erreur {
        switch reste.validiteParenthesage(ouvrante: "{", fermante: "}") {
        case .failure(let message):
            return Erreur(message: "On attend Chanson et rien après. " + message, reste: reste)
        case .success(_):
            return Erreur(message: "On attend Chanson et rien après", reste: reste)
        }
    }
    
    public var sourceRelisible: String {
        let texteParties = parties.map { "{ \($0.sourceRelisible) }" }.joined(separator: "\n")
        return texteParties
    }
}
    


public extension Chanson {
    
    /// Index de la dernière partie parmi les parties
    var indexDernierePartie: Int { parties.count - 1 }
    
    func laPartie(curseur: Curseur) -> Partie? {
        let index = curseur.partie
        guard index >= 0 && index < parties.count else {
            return nil
        }
        return parties[index]
    }
    
    func laLigne(curseur: Curseur) -> Ligne? {
        laPartie(curseur: curseur)?.laLigne(curseur: curseur)
    }
    
    func laMesure(curseur: Curseur) -> Mesure? {
        laLigne(curseur: curseur)?.laMesure(curseur: curseur)
    }
    
    func leTemps(curseur: Curseur) -> Temps? {
        laMesure(curseur: curseur)?.leTemps(curseur: curseur)
    }
    
    
    /// Vérifie que le curseur désigne bien une partie, une ligne, une mesure, un temps existant dans la chanson self.
    func estValide(curseur: Curseur) -> Bool {
        laPartie(curseur: curseur) != nil && laLigne(curseur: curseur) != nil && laMesure(curseur: curseur) != nil && leTemps(curseur: curseur) != nil
    }
    
    var nbParties: Int {
        parties.count
    }
    
    var nbLignes: Int {
        parties.reduce(0) { cumul, partie in
            cumul + partie.nbLignes
        }
    }
        
}

// MARK: - Acces par index de temps
// A partir d'un index désignant un temps, on peut retrouver curseur, temps, mesure, ligne, partie

public extension Chanson {
    
    var indexTempsMax: Int {
        nbTemps - 1
    }
    
    func estValide(indexTemps: Int) -> Bool {
        indexTemps >= 0 && indexTemps <= indexTempsMax
    }
    
    func leCurseur(indexTemps: Int) -> Curseur {
        assert(estValide(indexTemps: indexTemps))
        return lesCurseurs[indexTemps]
    }
    
    func leTemps(indexTemps: Int) -> Temps {
        assert(estValide(indexTemps: indexTemps))
        return lesTemps[indexTemps]
    }
    
    func laMesure(indexTemps: Int) -> Mesure {
        assert(estValide(indexTemps: indexTemps))
        guard let mesure = laMesure(curseur: leCurseur(indexTemps: indexTemps)) else {
            fatalError()
        }
        return mesure
    }
    
    func laLigne(indexTemps: Int) -> Ligne {
        assert(estValide(indexTemps: indexTemps))
        guard let ligne = laLigne(curseur: leCurseur(indexTemps: indexTemps)) else {
            fatalError()
        }
        return ligne
    }
    
    func laPartie(indexTemps: Int) -> Partie {
        assert(estValide(indexTemps: indexTemps))
        guard let partie = laPartie(curseur: leCurseur(indexTemps: indexTemps)) else {
            fatalError()
        }
        return partie
    }
    
    // Indique si le temps désigné par l'index est le dernier de sa mesure
    func estFinMesure(indexTemps: Int) -> Bool {
        let curseur = lesCurseurs[indexTemps]
        guard let mesure = laMesure(curseur: curseur) else {
            fatalError()
        }
        return curseur.temps == mesure.nbTemps - 1
    }
    
    func fenetreDeTemps(indexTemps: Int, largeur: Int = 4) -> [Int] {
        var liste = [Int]()
        var index = indexTemps
        while index <= indexTempsMax && index < indexTemps + largeur {
            liste.append(index)
            index += 1
        }
        return liste
    }
    
}


