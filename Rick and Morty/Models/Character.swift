import Foundation

struct CharactersResponseModel: Decodable {
    let info: Metadata?
    let results: [CharacterResponseModel]?
    
    func toCharacters() -> [Character] {
        let characters: [Character] = results?.compactMap {
            $0.toCharacter()
        } ?? []
        return characters
    }
}

struct Metadata: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    
    func isLastPage() -> Bool {
        next == nil
    }
}

struct CharacterResponseModel: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    func toCharacter() -> Character? {
        guard let id, let name, let status else { return nil }
        
        return Character(
            id: id,
            name: name,
            status: status,
            species: species ?? "",
            type: type ?? "",
            gender: gender ?? "",
            image: image ?? "",
            isFavorite: false
        )
    }
}

struct Character: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String

    var isFavorite: Bool
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}
