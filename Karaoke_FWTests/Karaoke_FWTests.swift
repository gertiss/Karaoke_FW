//
//  Karaoke_FWTests.swift
//  Karaoke_FWTests
//
//  Created by Gérard Tisseau on 01/12/2022.
//

import XCTest
@testable import Karaoke_FW
import RegexBuilder
import Lecteur

final class Karaoke_FWTests: XCTestCase {

    override func setUpWithError() throws {
        print()
    }

    override func tearDownWithError() throws {
        print()
    }

    func testRegex() {
        // Attention : ici, pas d'espaces ou tabs au début
        
        let match = "a b ".wholeMatch(of: RX.pleinPlein)
        let output = match!.output
        print(output)
        
        let match1 = "a ".wholeMatch(of: RX.pleinVide)
        let output1 = match1!.output
        print(output1)

        let match2 = "- a ".wholeMatch(of: RX.videPlein)
        let output2 = match2!.output
        print(output2)

        
        let match3 = "= ".wholeMatch(of: RX.videVide)
        let output3 = match3!.output
        print(output3)
    }
    
    func testLecteursPleinEtVide() {
        // Attention : ici, pas d'espaces ou tabs au début
        
        XCTAssertEqual(PleinPlein.lecteur.lire("ing in").valeur, PleinPlein(syllabe1: "ing", syllabe2: "in"))
        XCTAssertEqual(PleinVide.lecteur.lire("bed ").valeur, PleinVide(syllabe1: "bed"))
        XCTAssertEqual(VidePlein.lecteur.lire("- my ").valeur, VidePlein(syllabe2: "my"))
        XCTAssertEqual(VideVide.lecteur.lire("= ").valeur, VideVide())
        
   }
    
    func testLecteurTemps() {
        // Attention : ici, pas d'espaces ou tabs au début
        
        print("\n> ing in")
        print(Temps.lecteur.lire("ing in").texte)

        print("\n> - my")
        print(Temps.lecteur.lire("- my").texte)
        
        print("\n> bed")
        print(Temps.lecteur.lire("bed").texte)
        
        print("\n> ")
        print(Temps.lecteur.lire("").texte)
    }
    
    func testLecteurMesure() {
        print("\n> ly, ing in, - my, |")
        print(Mesure.lecteur.lire("ly, ing in, - my, |").texte)
        
        print("\n> ly, ing in, - my, a -")
        print(Mesure.lecteur.lire("ly, ing in, - my, a -").texte)
              
    }
    
    func testLecteurLigne() {
        var source = ("ly, ing in, - my, = |  ly, ing in, - my, = |  ly, ing in, - my, fin |")
        print("\n> \(source)")
        print(Ligne.lecteur.lire(source).texte)
        
        source = ("il vi, vait , en de, hors | des che, mins, fo res, tiers ")
        print("\n> \(source)")
        print(Ligne.lecteur.lire(source).texte)

        source = ("il vi, vait , en de, hors | des che, mins, fo res, tiers ")
        print("\n> \(source)")
        print(Ligne.lecteur.lire(source).texte)

        source = ("il vi, vait , en de, hors | des che, mins, fo res, tiers ")
        print("\n> \(source)")
        print(Ligne.lecteur.lire(source).texte)

    }
    
    func testLecteurPartie() {
        let source = "a b, - c, d, = \n e f, - g, h, ="
        print("\n> \(source)")
        print(Partie.lecteur.lire(source))
        print(Partie.lecteur.lire(source).valeur!.sourceRelisible)
    }
    
    func testWhiteSpace() {
        // CharacterClass.whitespace accepte les sauts de ligne !
        let source = "  \n a "
        let nnn = CharacterClass.whitespace

        let regex = Regex<(Substring, String)> {
            Capture {
                ZeroOrMore { nnn }
            } transform: {
                "|" + String($0) + "|"
            }
            OneOrMore { .word }
        }
        print(source.prefixMatch(of: regex)?.output ?? "nil")
        
    }
        
    func testAccolade() {
        let lectureOuvrante = AccoladeOuvrante.lecteur.lire(" { \n ")
        print(lectureOuvrante.texte)
        
        let lectureFermante = AccoladeFermante.lecteur.lire(" } \n ")
        print(lectureFermante.texte)
    }
    
    func testLecteurTexte() {
        let lecteur = Texte(string: "ab cd").lecteur
        let lecture = lecteur.lire("ab cd ef")
        XCTAssertEqual(lecture.texte.description, "􀆅 Texte(string: \"ab cd\") 􀄫\"ef\"")
    }
    
    func testSortieTemps() {
        let lecteur = Temps.lecteur
        print(lecteur.lire("=").valeur!.sortie)
        print(lecteur.lire("- my").valeur!.sortie)
        print(lecteur.lire("ly -").valeur!.sortie)
        print(lecteur.lire("ing in").valeur!.sortie)
   }
    
    func testSortieMesure() {
        let lecteur = Mesure.lecteur
        print(lecteur.lire("=, =, =, =").valeur!.sortie)
        print(lecteur.lire("ly, ing in, - my, =").valeur!.sortie)
        print(lecteur.lire("bed, I hear, - the, =").valeur!.sortie)
        print(lecteur.lire("clock, - tick, - and, =").valeur!.sortie)
        print(lecteur.lire("think of, - you, =, =").valeur!.sortie)
    }
    
    func testSortieLigne() {
        let lecteur = Ligne.lecteur
        let lecture = lecteur.lire("ly, ing in, - my, = | bed, I hear, - the, =")
        XCTAssert(lecture.estSucces)
        XCTAssertEqual(lecture.reste, "")
        XCTAssertEqual(lecture.valeur!.mesures.count, 2)
        print(lecture.valeur!.sortie)
        
        let lecture2 = lecteur.lire("clock, - tick, - and, = | think of, - you, =, =")
        XCTAssertEqual(lecture2.reste, "")
        XCTAssertEqual(lecture2.valeur!.mesures.count, 2)
        print(lecture2.valeur!.sortie)
  }
    
    func testSortieChanson() {
        let lecteur = Chanson.lecteur
        let lecture = lecteur.lire(timeAfterTime)
        print(lecture.texte)
    }
    
    func testMessagesErreur() {
        let lecteur = Chanson.lecteur
        print(lecteur.lireTout("titre\nauteur\n{- a, - - c, - d}b").texte)
    }
    
    func testTexte() {
        let lecteur = Texte.lecteur
        let lecture = lecteur.lire("\na\nb")
        print(lecture.texte)
        
        let lecteurChanson = Chanson.lecteur
        let lectureChanson = lecteurChanson.lire("\na\nb\n{z}")
        print(lectureChanson.texte)
    }
    
}
