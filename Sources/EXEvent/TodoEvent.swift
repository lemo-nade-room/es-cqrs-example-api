import EventStoreAdapter
import EventStoreAdapterSupport
package import Foundation

@EventSupport
package enum TodoEvent: EventStoreAdapter.Event {
    case created(Created)

    package typealias Id = UUID
    package typealias AID = TodoID

    package struct Created: Event {
        package var id: Id
        package var aid: AID
        package var seqNr: Int
        package var occurredAt: Date
        package var isCreated: Bool

        package var title: String
        package var description: String

        package init(
            id: Id,
            aid: AID,
            seqNr: Int,
            occurredAt: Date,
            isCreated: Bool,
            title: String,
            description: String,
        ) {
            self.id = id
            self.aid = aid
            self.seqNr = seqNr
            self.occurredAt = occurredAt
            self.isCreated = isCreated
            self.title = title
            self.description = description
        }
    }
}
