//
//  Temps.swift
//  Karaoke
//
//  Created by Gérard Tisseau on 28/11/2022.
//

import Foundation
import Lecteur
import RegexBuilder

public enum Temps: AvecLecteur, Hashable {
    case pleinPlein(PleinPlein)
    case pleinVide(PleinVide)
    case videPlein(VidePlein)
    case videVide(VideVide)
}

public extension Temps {
    
    static let lecteur = PleinPlein.lecteur.ou3(VidePlein.lecteur, PleinVide.lecteur, lecteur3: VideVide.lecteur)
        .mapValeur { choix in
            switch choix {
            case .cas0(let pp):
                return Temps.pleinPlein(pp)
            case .cas1(let vp):
                return Temps.videPlein(vp)
            case .cas2(let pv):
                return Temps.pleinVide(pv)
            case .cas3(let vv):
                return Temps.videVide(vv)
           }
        }
    
    var sourceRelisible: String {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.sourceRelisible
        case .pleinVide(let pleinVide):
            return pleinVide.sourceRelisible
        case .videPlein(let videPlein):
            return videPlein.sourceRelisible
        case .videVide(let videVide):
            return videVide.sourceRelisible
        }
    }
    
    var description: String {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.description
        case .pleinVide(let pleinVide):
            return pleinVide.description
        case .videPlein(let videPlein):
            return videPlein.description
        case .videVide(let videVide):
            return videVide.description
        }
    }
    
    var syllabe1: String {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.syllabe1
        case .pleinVide(let pleinVide):
            return pleinVide.syllabe1
        case .videPlein(_):
            return "-"
        case .videVide(_):
            return "-"
        }
    }
    
    var syllabe2: String {
        switch self {
        case .pleinPlein(let pleinPlein):
            return pleinPlein.syllabe2
        case .pleinVide(_):
            return "-"
        case .videPlein(let videPlein):
            return videPlein.syllabe2
        case .videVide(_):
            return "-"
        }
    }

    
}

