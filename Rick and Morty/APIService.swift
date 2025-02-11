import Foundation

final class APIService {
    
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
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(CharactersResponseModel.self, from: data)
        }
        catch {
            throw error
        }
    }
}
