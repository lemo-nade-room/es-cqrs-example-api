package struct TodoList: Sendable, Hashable, Codable {
    package var items: [Item]

    package init(items: [Item]) {
        self.items = items
    }
}
