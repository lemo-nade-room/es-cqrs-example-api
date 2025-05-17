import EXEvent
import EXTestUtil
import Foundation
import Testing

@Suite struct UUIDLosslessStringConvertibleTests {
    @Test(.enabled(if: small))
    func ロスなくStringに変換可能() {
        let uuid = UUID()

        let actual = UUID(uuid.description)

        #expect(actual == uuid)
    }
}
