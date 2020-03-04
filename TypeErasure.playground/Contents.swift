import UIKit
import Foundation

struct Fire {}
struct Electric {}

protocol Pokemon {
    associatedtype PokemonType
    func attack(move:PokemonType)
}

class Pikachu: Pokemon {
    func attack(move: Electric) { }
}

class Charmander: Pokemon {
    func attack(move: Fire) { }
}



class AnyPokemon <PokemonType>: Pokemon {
    func attack(move: PokemonType) {}
    required init<U:Pokemon>(_ pokemon: U) where U.PokemonType == PokemonType {}
}

let p1 = AnyPokemon(Pikachu())

let p2: AnyPokemon<Fire>
p2 = AnyPokemon(Charmander())
