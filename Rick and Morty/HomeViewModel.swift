import Foundation

final class HomeViewModel {
    
    private let apiService = APIService()
    
    init() {
        Task {
            do {
                try await apiService.fetchCharacters()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
