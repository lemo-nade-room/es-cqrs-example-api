import Dependencies
import EXApp
import EXEvent
import EXTestUtil
import EXWrite
import EventStoreAdapterForMemory
import Foundation
import Testing

@Suite struct TodoCreateCommandHandlerTests {
    @Test(.enabled(if: small))
    func 初期値Todoを新たに作成しそのIDが取得できる() async throws {
        // Arrange
        let eventStore: some Todo.EventStore = EventStoreForMemory<Todo.Snapshot, TodoEvent>()
        let now = ISO8601DateFormatter().date(from: "2024-06-22T12:34:56Z")!

        let sut = withDependencies {
            $0.uuid = .incrementing
            $0.date = .constant(now)
            $0.todoEventStore = eventStore
        } operation: {
            TodoCreateCommand.Handler()
        }

        // Act
        let result = try await sut.handle(command: .init())

        // Assert
        let todoID = TodoID("00000000-0000-0000-0000-000000000001")!
        #expect(result == todoID)

        let snapshot = try await eventStore.getLatestSnapshotByAID(aid: todoID)
        #expect(
            snapshot
                == .init(
                    aid: todoID,
                    seqNr: 1,
                    version: 1,
                    lastUpdatedAt: now,
                    title: "Empty",
                    description: "",
                )
        )

        let events = try await eventStore.getEventsByAIDSinceSequenceNumber(aid: todoID, seqNr: 1)
        #expect(
            events == [
                .created(
                    .init(
                        id: .init(uuidString: "00000000-0000-0000-0000-000000000000")!,
                        aid: todoID,
                        seqNr: 1,
                        occurredAt: now,
                        isCreated: true,
                        title: "Empty",
                        description: "",
                    )
                )
            ]
        )
    }
}
