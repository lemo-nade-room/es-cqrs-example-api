extension Todo {
    final class Title: Sendable, Hashable, Codable {
        static let maxCount = 100
        let value: String
        init?(value: String) {
            guard value.count <= Self.maxCount else {
                return nil
            }
            if value.contains("\n") {
                return nil
            }
            self.value = value
        }
        static func == (lhs: Title, rhs: Title) -> Bool {
            lhs.value == rhs.value
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
}
