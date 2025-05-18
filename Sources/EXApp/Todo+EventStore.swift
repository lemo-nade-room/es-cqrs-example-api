package import Dependencies
package import EXEvent
package import EXWrite
package import EventStoreAdapter

extension Todo {
    package protocol EventStore: EventStoreAdapter.EventStore
    where
        AID == TodoID,
        Event == TodoEvent,
        Aggregate == Todo.Snapshot
    {}
}

extension DependencyValues {
    private struct TodoEventStoreKey: DependencyKey {
        static var liveValue: any Todo.EventStore {
            fatalError("起動にはTodo.EventStoreの注入セットアップが必要です")
        }
    }

    package var todoEventStore: any Todo.EventStore {
        get { self[TodoEventStoreKey.self] }
        set { self[TodoEventStoreKey.self] = newValue }
    }
}
