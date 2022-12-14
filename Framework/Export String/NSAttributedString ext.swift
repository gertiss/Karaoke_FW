//
//  NSAttribuetdString ext.swift
//  Karaoke_FW
//
//  Created by Gérard Tisseau on 10/12/2022.
//

import Foundation
import AppKit


public extension String {
    var avecStyle: NSAttributedString {
        NSAttributedString(string: self)
    }
}

public extension NSAttributedString {
    
    var rtf: Data? {
        rtf(from: tout)
    }
    
    /// Rend self mutable pour pouvoir ajouter des attributs procéduralement
    var mutable: NSMutableAttributedString {
        NSMutableAttributedString(attributedString: self)
    }
    
    /// Le NSRange qui couvre toute la String
    var tout: NSRange {
        NSRange(location: 0, length: self.length)
    }
    
    func enGras(taille: Int = 0) -> NSAttributedString {
        let texte = self.mutable
        let font = NSFont.systemFont(ofSize: CGFloat(taille), weight: .bold)
        texte.addAttribute(.font, value: font, range: texte.tout)
        return texte
    }
 
    /// Modifie la couleur de toute la String
    func avecCouleur(_ couleur: NSColor) -> NSAttributedString {
        let texte = self.mutable
        texte.addAttribute(.foregroundColor, value: couleur, range: texte.tout)
        return texte
    }
    
    /// Modifie la taille de la police de toute la String (avec police systemFont)
    func avecTaille(_ taille: Int) -> NSAttributedString {
        let texte = self.mutable
        let font = NSFont.systemFont(ofSize: CGFloat(taille))
        texte.addAttribute(.font, value: font, range: texte.tout)
        return texte
    }
    
    func enregistrerEnRtf(url: URL) throws {
        guard let rtf else {
            throw "Impossible de convertir \(self) en rtf"
        }
        try rtf.write(to: url)
        print("Enregistré dans \(url.lastPathComponent)")
    }
    
    func joint(avec autre: NSAttributedString) -> NSAttributedString {
        let resultat = self.mutable
        resultat.append(autre)
        return resultat
    }
}


public extension [NSAttributedString] {
    
    func joint(separateur: NSAttributedString) -> NSAttributedString {
        guard let premier = first else {
            return "".avecStyle
        }
        if count == 1 {
            return premier
        }
        let reste = dropFirst().map { $0 }
        return premier.joint(avec: separateur).joint(avec: reste.joint(separateur: separateur))
    }
}

