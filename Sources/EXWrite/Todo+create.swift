package import Dependencies
package import EXEvent

extension Todo {
    package static func create(
        uuidGenerator: UUIDGenerator,
        dateGenerator: DateGenerator,
        title: String,
        description: String
    ) throws -> (todo: Todo, event: TodoEvent) {
        guard let title = Title(value: title) else {
            throw CreateError.invalidTitle
        }
        guard let description = Description(value: description) else {
            throw CreateError.invalidDescription
        }

        let event = TodoEvent.Created(
            id: uuidGenerator.callAsFunction(),
            aid: .init(uuid: uuidGenerator.callAsFunction()),
            seqNr: 1,
            occurredAt: dateGenerator.callAsFunction(),
            isCreated: true,
            title: title.value,
            description: description.value,
        )

        let todo = Todo(
            aid: event.aid,
            seqNr: event.seqNr,
            version: 1,
            lastUpdatedAt: event.occurredAt,
            title: .init(value: event.title)!,
            description: .init(value: event.description)!,
        )

        return (todo, event: .created(event))
    }

    package enum CreateError: Error, Sendable, Hashable, Codable {
        case invalidTitle
        case invalidDescription
    }
}
