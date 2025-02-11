import Foundation

struct CharacterQueryParameters {
    let page: Int?
    let name: String?
    let status: String?
    
    var queryItems: [URLQueryItem] = []
    
    init(page: Int? = nil, name: String? = nil, status: String? = nil) {
        self.page = page
        self.name = name
        self.status = status
        
        if let page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        
        if let name {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        if let status {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
    }
}
