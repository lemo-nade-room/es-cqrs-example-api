import EventStoreAdapter
package import Foundation

package final class TodoID: AggregateId {
    package static var name: String { "todo" }

    package let uuid: UUID

    package init(uuid: UUID) {
        self.uuid = uuid
    }

    package convenience init?(_ description: String) {
        guard let uuid = UUID(uuidString: description) else {
            return nil
        }
        self.init(uuid: uuid)
    }

    package static func == (lhs: TodoID, rhs: TodoID) -> Bool {
        lhs.uuid == rhs.uuid
    }

    package func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    package var description: String { uuid.description }
}
