import Dependencies
import EXTestUtil
import Foundation
import Testing

@testable import EXWrite

@Suite struct TodoCreateTests {
    @Test(.enabled(if: small))
    func Todoを作成できる() async throws {
        // Arrange
        let now = ISO8601DateFormatter().date(from: "2025-04-02T12:34:56Z")!

        // Act
        let (todo, event) = try Todo.create(
            uuidGenerator: .incrementing,
            dateGenerator: .constant(now),
            title: "Empty",
            description: "",
        )

        // Assert
        let snapshot = await todo.snapshot
        #expect(
            event
                == .created(
                    .init(
                        id: .init(uuidString: "00000000-0000-0000-0000-000000000000")!,
                        aid: .init(
                            uuid: .init(uuidString: "00000000-0000-0000-0000-000000000001")!),
                        seqNr: 1,
                        occurredAt: now,
                        isCreated: true,
                        title: "Empty",
                        description: "",
                    )
                )
        )
        #expect(
            snapshot
                == .init(
                    aid: .init(uuid: .init(uuidString: "00000000-0000-0000-0000-000000000001")!),
                    seqNr: 1,
                    version: 1,
                    lastUpdatedAt: now,
                    title: "Empty",
                    description: "",
                )
        )
    }

    @Test(.enabled(if: small))
    func 不正なタイトルで作成しようとするとエラーが投げられる() async throws {
        // Arrange
        let now = ISO8601DateFormatter().date(from: "2025-04-02T12:34:56Z")!

        // Assert
        #expect(throws: Todo.CreateError.invalidTitle) {
            // Act
            _ = try Todo.create(
                uuidGenerator: .incrementing,
                dateGenerator: .constant(now),
                title: """
                    こんにちは
                    不正なタイトルです
                    """,
                description: "",
            )
        }
    }

    @Test(.enabled(if: small))
    func 不正な説明で作成しようとするとエラーが投げられる() async throws {
        // Arrange
        let now = ISO8601DateFormatter().date(from: "2025-04-02T12:34:56Z")!

        // Assert
        #expect(throws: Todo.CreateError.invalidDescription) {
            // Act
            _ = try Todo.create(
                uuidGenerator: .incrementing,
                dateGenerator: .constant(now),
                title: "Hello",
                description: String(repeating: "あ", count: 1001),
            )
        }
    }
}
