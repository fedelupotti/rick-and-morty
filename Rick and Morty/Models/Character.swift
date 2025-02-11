import Foundation

struct CharactersResponseModel: Decodable {
    let info: Metadata?
    let results: [CharacterResponseModel]?
}

struct Metadata: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
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
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}
