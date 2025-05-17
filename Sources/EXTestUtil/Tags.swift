import Foundation

package var small: Bool {
    ProcessInfo.processInfo.environment["SMALL"] == "true"
}
package var medium: Bool {
    ProcessInfo.processInfo.environment["MEDIUM"] == "true"
}
package var large: Bool {
    ProcessInfo.processInfo.environment["LARGE"] == "true"
}
