import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                List {
                    ForEach(homeViewModel.characters) { character in
                        HStack(alignment: .center) {
                            Text(character.name)
                            
                            Spacer()
                            
                            AsyncImage(url: URL(string: character.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: homeViewModel.favoriteGesture, label: {
                                Image(systemName: "star")
                                    .resizable()
                                    .tint(character.isFavorite ? .yellow : nil)
                            })
                        }
                    }
                    
                    paginationFooter()
                }
                .onAppear {
                    homeViewModel.getAllCharacters()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                Text("Some Text")
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                
            }
            .navigationTitle("Rick and Morty")

        }
    }

    @ViewBuilder
    private func paginationFooter() -> some View {
        switch homeViewModel.state {
        case .idle:
            Color.clear
                .frame(maxWidth: .infinity)
                .onAppear {
                    homeViewModel.getAllCharacters()
                }
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity)
        case .noMorePages:
            Text("No more pages")
                .frame(maxWidth: .infinity)
        case .error(let message):
            ErrorView(message: message) {
                homeViewModel.getAllCharacters()
            }
        }
    }
}

struct ErrorView: View {
    let message: String
    let onPress: () -> Void
    
    var body: some View {
        Button(action: onPress, label: {
            Text("Reload data")
        })
    }
}

#Preview {
    ContentView()
}
