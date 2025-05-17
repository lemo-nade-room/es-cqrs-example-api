extension Todo {
    final class Description: Sendable, Hashable, Codable {
        static let maxCount = 1000
        let value: String
        init?(value: String) {
            guard value.count <= Self.maxCount else {
                return nil
            }
            self.value = value
        }
        static func == (lhs: Description, rhs: Description) -> Bool {
            lhs.value == rhs.value
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
}
