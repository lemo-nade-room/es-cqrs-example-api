package import EXEvent

package actor Todo {
    package nonisolated let aid: TodoID
    var title: Title
    var description: Description

    init(aid: TodoID, title: Title, description: Description) {
        self.aid = aid
        self.title = title
        self.description = description
    }
}
