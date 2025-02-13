import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        List {
            ForEach(homeViewModel.characters) { character in
                Text(character.name)
            }
            paginationFooter()
        }
        .onAppear {
            homeViewModel.getAllCharacters()
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
