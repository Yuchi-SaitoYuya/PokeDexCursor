import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            } placeholder: {
                ProgressView()
            }
            
            Text(pokemon.name.capitalized)
                .font(.headline)
                .padding(.top, 8)
            
            Text("#\(pokemon.id)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
} 