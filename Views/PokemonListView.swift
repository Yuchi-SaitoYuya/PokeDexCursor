import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.pokemons) { pokemon in
                            PokemonCardView(pokemon: pokemon)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("ポケモン図鑑")
            .background(Color(.systemGray6))
            .onAppear {
                viewModel.fetchPokemons()
            }
        }
    }
} 