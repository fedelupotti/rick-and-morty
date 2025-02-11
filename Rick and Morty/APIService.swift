import Foundation

final class APIService {
    
    func fetchCharacters() async throws -> CharactersResponseModel {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            throw NSError(domain: "URL not found", code: 0)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            let charactersResponseModel = try decoder.decode(CharactersResponseModel.self, from: data)
            print(charactersResponseModel)
            return charactersResponseModel
        }
        catch {
            throw error
        }
    }
}
