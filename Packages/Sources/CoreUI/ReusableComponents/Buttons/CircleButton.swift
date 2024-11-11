//
//  CircleButton.swift
//  Main
//
//  Created by Krzysztof Lema on 11/11/2024.
//

import SwiftUI

public struct CircleButton: View {
    var iconImage: Image
    var circleButtonAction: (() -> Void)?

    public init(
        iconImage: Image,
        circleButtonAction: (() -> Void)? = nil
    ) {
        self.iconImage = iconImage
        self.circleButtonAction = circleButtonAction
    }

    public var body: some View {
        closeButton
    }

    @ViewBuilder
    private var closeButton: some View {
        if let circleButtonAction {
            Button {
                circleButtonAction()
            } label: {
                iconImage
            }
            .asCircleButtonStyle()
        }
    }
}
