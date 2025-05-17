import EXTestUtil
import Testing

@testable import EXWrite

@Suite struct TodoDescriptionTests {
    @Test(
        .enabled(if: small),
        arguments: [
            """
            ## 概要
            Todoを作成するWeb APIのOpenAPI定義を作成する
            """,
            "",
            "あとで書く",
            String(repeating: "A", count: 1000),
        ]
    )
    func TodoDescriptionが正しい値で初期化できる(text: String) throws {
        let description = try #require(Todo.Description(value: text))
        #expect(description.value == text)
    }

    @Test(.enabled(if: small))
    func TodoDescriptionが不正値で初期化できない() throws {
        let text = String(repeating: "A", count: 1001)
        #expect(Todo.Description(value: text) == nil)
    }
}
