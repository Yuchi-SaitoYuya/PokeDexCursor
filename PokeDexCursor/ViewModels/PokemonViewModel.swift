import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let service = PokemonService()
    
    func fetchPokemons() {
        isLoading = true
        error = nil
        
        Task {
            do {
                pokemons = try await service.fetchPokemons()
                isLoading = false
            } catch {
                self.error = "ポケモンデータの取得に失敗しました"
                isLoading = false
            }
        }
    }
} 