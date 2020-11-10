//
//  FontExtensions.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 11/2/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//
import SwiftUI

enum PulsarStyle{
    case h1
    case h2
    case h3
    case subhead
    case body
    case lessEmphasis
    case moreEmphasis
    case primaryButton
    case secondaryButton
}


@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
    func pulsarFont(style: PulsarStyle) -> some View {
        switch style {
        case .h1:
            return self.modifier(ScaledFont(name: "SourceSansPro-Black", size: 60))
        case .h2:
            return self.modifier(ScaledFont(name: "SourceSansPro-BlackItalic", size: 40))
        case .h3:
            return self.modifier(ScaledFont(name: "SourceSansPro-Black", size: 28))
        case .subhead:
            return self.modifier(ScaledFont(name: "SourceSansPro-SemiBoldItalic", size: 22))
        case .body:
            return self.modifier(ScaledFont(name: "SourceSansPro-Regular", size: 20))
        case .lessEmphasis:
            return self.modifier(ScaledFont(name: "SourceSansPro-Light", size: 18))
        case .moreEmphasis:
            return self.modifier(ScaledFont(name: "SourceSansPro-SemiBold", size: 20))
        case .primaryButton:
            return self.modifier(ScaledFont(name: "SourceSansPro-SemiBold", size: 22))
        case .secondaryButton:
            return self.modifier(ScaledFont(name: "SourceSansPro-Italic", size: 22))
        }
    }
}
