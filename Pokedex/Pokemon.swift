//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fareen on 10/25/17.
//  Copyright © 2017 Fareen. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        
        return _baseAttack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        
        return _nextEvolutionTxt
    }
    
    init(name: String, pokedex: Int) {
        self._name = name
        self._pokedexID = pokedex
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self._pokedexID!)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let height = dict["height"] as? Int {
                    self._height = "\(height)"
                }
                
                if let weight = dict["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>], stats.count > 0 {
                    if let baseAttack = stats[4]["base_stat"] as? Int {
                        self._baseAttack = "\(baseAttack)"
                    }
                    
                    if let defense = stats[3]["base_stat"] as? Int {
                        self._defense = "\(defense)"
                    }
                }
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    print("count: \(types.count)")
                    
                    if let type = types[0]["type"] as? Dictionary<String, String> {
                        if let typeName = type["name"] {
                            self._type = typeName.capitalized
                        }
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let type = types[x]["type"] as? Dictionary<String, String> {
                                if let typeName = type["name"] {
                                    self._type! += "/\(typeName.capitalized)"
                                }
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
            }
            
            completed()
        }
    }
}
