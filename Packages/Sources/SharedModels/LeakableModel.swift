import Foundation
import LifetimeTracker
import SwiftUI

public class LeakableModel: ObservableObject, LifetimeTrackable {
    public static var lifetimeConfiguration: LifetimeConfiguration = .init(maxCount: 1)

    public init() {
        trackLifetime()
    }
}
