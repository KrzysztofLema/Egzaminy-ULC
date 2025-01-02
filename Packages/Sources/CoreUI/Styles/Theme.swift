import SwiftUI

extension Color {
    public static let primaryBackground = Color(PlatformColor.dynamicColor(
        light: PlatformColor(hex: 0xc7dfff),
        dark: PlatformColor(hex: 0x1b202c)
    ))
    public static let buttonBackgroundColor = Color(PlatformColor(hex: 0xb3b3b3))
    public static let buttonDisabledBackgroundColor = Color(PlatformColor(hex: 0x86888f00))
}

#if canImport(UIKit)
typealias PlatformColor = UIColor
#elseif canImport(AppKit)
typealias PlatformColor = NSColor
#endif

extension PlatformColor {
    static func dynamicColor(light: PlatformColor, dark: PlatformColor) -> PlatformColor {
        #if canImport(UIKit)
        return PlatformColor { $0.userInterfaceStyle == .dark ? dark : light }
        #elseif canImport(AppKit)
        return NSColor(name: nil) { appearance in
            switch appearance.bestMatch(from: [.darkAqua, .aqua]) {
            case .darkAqua: return dark
            default: return light
            }
        }
        #endif
    }

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
