import AsyncHTTPClient
import EXTestUtil
import Foundation
import OpenAPIAsyncHTTPClient
import OpenAPIRuntime
import Testing

@Test(.tags(.medium))
func WebAPIでTodoを作成できる() async throws {
    // Arrange
    let serverURLString =
        ProcessInfo.processInfo.environment["SERVER_URL"] ?? "http://127.0.0.1:8080"
    guard let serverURL = URL(string: serverURLString) else {
        fatalError("環境変数 SERVER_URLが正しく設定されていません: '\(serverURLString)'")
    }

    let client = Client(serverURL: serverURL, transport: AsyncHTTPClientTransport())

    // Act
    let response = try await client.createTodo(.init())

    // Assert
    print(response)
    let createdTodoId = try response.created.body.json.id
    let getTodoResponse = try await client.getTodoById(
        .init(path: .init(id: createdTodoId))
    )
    let gotTodo = try getTodoResponse.ok.body.json
    #expect(gotTodo == .init(id: createdTodoId, title: "Empty", description: ""))
}
