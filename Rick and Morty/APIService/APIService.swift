import Foundation

protocol NetworkService {
    func fetchData(url: URL) async throws -> Data
}

final class APIService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = URLSession.shared) {
        self.networkService = networkService
    }
    
    func fetchCharacters(with parameters: CharacterQueryParameters = .init()) async throws -> CharactersResponseModel {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/character"
        components.queryItems = parameters.queryItems.isEmpty ? nil : parameters.queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        do {
            let data = try await networkService.fetchData(url: url)
            
            let decoder = JSONDecoder()
            return try decoder.decode(CharactersResponseModel.self, from: data)
        }
        catch {
            throw error
        }
    }
}

extension URLSession: NetworkService {
    func fetchData(url: URL) async throws -> Data {
        let (data, response) = try await data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
