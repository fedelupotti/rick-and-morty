import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @MainActor
    @Published private(set) var characters: [Character] = []
    
    @MainActor
    @Published private(set) var state: State = .idle
    
    private var nextPageNumber: Int = 35
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func getAllCharacters() {
        guard state != .loading,
              state != .noMorePages else { return }

        state = .loading
        Task {
            do {
                let queryParameters = CharacterQueryParameters(page: nextPageNumber)
                let data = try await apiService.fetchCharacters(with: queryParameters)
                let newCharacters = data.toCharacters()
                
                characters.append(contentsOf: newCharacters)
                
                if data.info?.isLastPage() == true {
                    state = .noMorePages
                } else {
                    state = .idle
                    nextPageNumber += 1
                }
            } catch {
                state = .error(message: error.localizedDescription)
            }
        }
    }
}

extension HomeViewModel {
    enum State: Equatable {
        case idle
        case loading
        case noMorePages
        case error(message: String)
    }
}
