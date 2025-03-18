import Foundation

class PokemonService {
    private let baseURL = "https://pokeapi.co/api/v2"
    
    func fetchPokemon(id: Int) async throws -> Pokemon {
        let url = URL(string: "\(baseURL)/pokemon/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Pokemon.self, from: data)
    }
    
    func fetchPokemons(limit: Int = 151) async throws -> [Pokemon] {
        let url = URL(string: "\(baseURL)/pokemon?limit=\(limit)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        
        var pokemons: [Pokemon] = []
        for (index, _) in response.results.enumerated() {
            let pokemon = try await fetchPokemon(id: index + 1)
            pokemons.append(pokemon)
        }
        return pokemons
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
} 