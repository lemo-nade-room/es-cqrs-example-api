import EXEvent
import EXWrite
import EventStoreAdapterForMemory

extension EventStoreForMemory<Todo.Snapshot, TodoEvent>: Todo.EventStore {}
