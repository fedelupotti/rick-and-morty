import XCTest
@testable import Rick_and_Morty

final class Rick_and_MortyTests: XCTestCase {
    var sut: APIService!
    var mockNetworkService: MockNetworkService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        sut = APIService(
            networkService: MockNetworkService(result: .failure(URLError(.notConnectedToInternet)))
        )
        do {
            let result = try await sut.fetchCharacters()
            XCTFail()
        }
        catch {
            XCTAssertTrue(error as? URLError == URLError(.notConnectedToInternet))
        }
    }
}
