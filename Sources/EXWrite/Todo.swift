package import EXEvent
import Foundation

package actor Todo {
    package nonisolated let aid: TodoID
    var seqNr: Int
    package nonisolated let version: Int
    var lastUpdatedAt: Date

    var title: Title
    var description: Description

    init(
        aid: TodoID,
        seqNr: Int,
        version: Int,
        lastUpdatedAt: Date,
        title: Title,
        description: Description
    ) {
        self.aid = aid
        self.seqNr = seqNr
        self.version = version
        self.lastUpdatedAt = lastUpdatedAt
        self.title = title
        self.description = description
    }
}
