import EXTestUtil
import Testing

@testable import EXWrite

@Suite struct TodoTitleTests {
    @Test(
        .tags(.small),
        arguments: [
            "",
            "スルメを買う",
            String(repeating: "A", count: 100),
        ]
    )
    func TodoTitleが正しい値で初期化できる(text: String) throws {
        let title = try #require(Todo.Title(value: text))
        #expect(title.value == text)
    }

    @Test(
        .tags(.small),
        arguments: [
            """
            改行が
            入っている
            文字列
            """,
            String(repeating: "A", count: 101),
        ]
    )
    func TodoTitleが不正値で初期化できない(text: String) throws {
        #expect(Todo.Title(value: text) == nil)
    }
}
