import EXEvent
import EXProjection
import EXReadModel
import EXTestUtil
import Foundation
import Testing

@Suite struct ProjectTodoCreatedToTodoListTests {
    @Test(.enabled(if: small))
    func 最初のTodoが作成されたらそのTodoListが作成される() throws {
        // Arrange
        let todoID = TodoID("00000000-0000-0000-0000-000000000001")!

        let event = TodoEvent.Created(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
            aid: todoID,
            seqNr: 1,
            occurredAt: ISO8601DateFormatter().date(from: "2024-01-01T00:00:00Z")!,
            isCreated: true,
            title: "Empty",
            description: ""
        )

        // Act
        let next = projectTodoCreatedToTodoList(previous: nil, event: event)

        // Assert
        #expect(next == .init(items: [.init(id: todoID.uuid, title: "Empty", description: "")]))
    }

    @Test(.enabled(if: small))
    func 既存のTodoListが存在する場合にTodoが作成されたら最後のTodoとして追加される() throws {
        // Arrange
        let todoID = TodoID("00000000-0000-0000-0000-000000000004")!

        let event = TodoEvent.Created(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            aid: todoID,
            seqNr: 1,
            occurredAt: ISO8601DateFormatter().date(from: "2024-01-01T00:00:00Z")!,
            isCreated: true,
            title: "Empty",
            description: "",
        )

        let previous = TodoList(
            items: [
                .init(
                    id: .init(uuidString: "00000000-0000-0000-0000-000000000001")!,
                    title: "Hello",
                    description: "World",
                ),
                .init(
                    id: .init(uuidString: "00000000-0000-0000-0000-000000000002")!,
                    title: "こんにちは",
                    description: "世界",
                ),
            ]
        )

        // Act
        let next = projectTodoCreatedToTodoList(previous: previous, event: event)

        // Assert
        #expect(
            next
                == .init(
                    items: [
                        .init(
                            id: .init(uuidString: "00000000-0000-0000-0000-000000000001")!,
                            title: "Hello",
                            description: "World",
                        ),
                        .init(
                            id: .init(uuidString: "00000000-0000-0000-0000-000000000002")!,
                            title: "こんにちは",
                            description: "世界",
                        ),
                        .init(
                            id: .init(uuidString: "00000000-0000-0000-0000-000000000004")!,
                            title: "Empty",
                            description: "",
                        ),
                    ]
                )
        )
    }
}
