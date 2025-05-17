import EXTestUtil
import Foundation
import Testing
import EXEvent

@Suite struct UUIDLosslessStringConvertibleTests {
    func ロスなくStringに変換可能() {
        let uuid = UUID()
        
        let actual = UUID(uuid.description)
        
        #expect(actual == uuid)
    }
}
