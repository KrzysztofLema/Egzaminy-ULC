import SwiftUI

extension Color {
    public static let primaryBackground = Color(uiColor: UIColor.dynamicColor(light: .init(hex: 0xc7dfff), dark: .init(hex: 0x1b202c)))
    public static let buttonBackgroundColor = Color(uiColor: .init(hex: 0xb3b3b3))
    public static let buttonDisabledBackgroundColor = Color(uiColor: .init(hex: 0x86888f00))
}

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        UIColor { $0.userInterfaceStyle == .dark ? dark : light }
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
