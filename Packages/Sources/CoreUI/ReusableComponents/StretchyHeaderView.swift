import SwiftUI
import Foundation

public struct StretchyHeaderView<Content: View>: View {
    private var content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public func headerHeight(using proxy: GeometryProxy) -> CGFloat {
        return proxy.frame(in: .named("ExamDetails.ScrollView")).minY > 0
        ? 300 + proxy.frame(in: .named("ExamDetails.ScrollView")).minY
        : 300
    }
    
    public var body: some View {
        GeometryReader { proxy in
            content
            
            .frame(width: proxy.size.width, height: headerHeight(using: proxy))
            .offset(y: proxy.frame(in: .named("ExamDetails.ScrollView")).minY > 0 ? -proxy.frame(in: .named("ExamDetails.ScrollView")).minY : 0)
        }.frame(height: 300)
    }
}
