//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Fareen on 10/27/17.
//  Copyright © 2017 Fareen. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heigntLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "\(pokemon.pokedexID)")
        
        nameLbl.text = pokemon.name.capitalized
        pokedexIDLbl.text = "\(pokemon.pokedexID)"
        mainImg.image = image
        currentEvoImg.image = image
        
        pokemon.downloadPokemonDetail {
            // whatever we write will only be called after the network call is complete.
            self.updateUI()
        }

    }
    
    func updateUI() {
        nameLbl.text = pokemon.name.capitalized
        heigntLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.baseAttack
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
