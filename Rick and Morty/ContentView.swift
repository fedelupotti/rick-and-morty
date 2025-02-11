import SwiftUI

struct ContentView: View {
    private let homeVM = HomeViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, worlda!")
        }
    }
}

#Preview {
    ContentView()
}
