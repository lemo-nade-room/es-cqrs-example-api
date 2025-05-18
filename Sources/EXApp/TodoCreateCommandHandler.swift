import Dependencies
package import EXEvent
import EXWrite

package struct TodoCreateCommand: Sendable, Hashable, Codable {
    package init() {}
}

extension TodoCreateCommand {
    package struct Handler: Sendable, DependencyKey {
        package static var liveValue: Self { .init() }
        package static var testValue: Self { .init() }
        package init() {}

        @Dependency(\.uuid) private var uuidGenerator
        @Dependency(\.date) private var dateGenerator
        @Dependency(\.todoEventStore) private var eventStore

        package func handle(command: TodoCreateCommand) async throws -> TodoID {
            let (todo, event) = try Todo.create(
                uuidGenerator: uuidGenerator,
                dateGenerator: dateGenerator,
                title: "Empty",
                description: "",
            )

            try await eventStore.persistEventAndSnapshot(event: event, aggregate: todo.snapshot)

            return todo.aid
        }
    }
}
