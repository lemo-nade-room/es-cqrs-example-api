package import Foundation

extension TodoList {
    package struct Item: Sendable, Hashable, Codable {
        package var id: UUID
        package var title: String
        package var description: String

        package init(id: UUID, title: String, description: String) {
            self.id = id
            self.title = title
            self.description = description
        }
    }
}
