package import EXEvent
import EventStoreAdapter
package import Foundation

extension Todo {
    package struct Snapshot: Aggregate {
        package var aid: TodoID
        package var seqNr: Int
        package var version: Int
        package var lastUpdatedAt: Date

        package var title: String
        package var description: String

        package init(
            aid: TodoID,
            seqNr: Int,
            version: Int,
            lastUpdatedAt: Date,
            title: String,
            description: String
        ) {
            self.aid = aid
            self.seqNr = seqNr
            self.version = version
            self.lastUpdatedAt = lastUpdatedAt
            self.title = title
            self.description = description
        }
    }

    package init(snapshot: Snapshot) {
        self.init(
            aid: snapshot.aid,
            seqNr: snapshot.seqNr,
            version: snapshot.version,
            lastUpdatedAt: snapshot.lastUpdatedAt,
            title: .init(value: snapshot.title)!,
            description: .init(value: snapshot.description)!,
        )
    }

    package var snapshot: Snapshot {
        .init(
            aid: aid,
            seqNr: seqNr,
            version: version,
            lastUpdatedAt: lastUpdatedAt,
            title: title.value,
            description: description.value,
        )
    }
}
