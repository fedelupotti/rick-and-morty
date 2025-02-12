import Foundation

final class MockNetworkService: NetworkService {
    var result: Result<Data, URLError>
    
    init(result: Result<Data, URLError>) {
        self.result = result
    }
    
    func fetchData(url: URL) async throws -> Data {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
