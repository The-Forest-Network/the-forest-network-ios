//
// Copyright 2025 Element Creations Ltd.
// Copyright 2023-2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import SwiftUI

/// The background gradient shown on the launch, splash and onboarding screens.
struct AuthenticationStartScreenBackgroundImage: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        MeshGradient(width: 3, height: 4, points: [
            .init(0, 0), .init(0.5, 0), .init(1, 0),
            .init(0, 0.30), .init(0.5, 0.30), .init(1, 0.30),
            .init(0, 0.68), .init(0.5, 0.68), .init(1, 0.68),
            .init(0, 1), .init(0.5, 1), .init(1, 1)
        ], colors: colorScheme == .dark ? darkColors : lightColors)
            .ignoresSafeArea()
            .accessibilityHidden(true)
    }
    
    private let lightColors: [Color] = [
        // top row — sampled from original asset
        Color(red: 0.894, green: 0.957, blue: 0.976), // #e4f4f9
        Color(red: 0.859, green: 0.922, blue: 0.973), // #dbebf8
        Color(red: 0.910, green: 0.937, blue: 0.984), // #e8effb
        // mid row — sampled from original asset
        Color(red: 0.255, green: 0.765, blue: 0.839), // #41c3d6 cyan left
        Color(red: 0.271, green: 0.655, blue: 0.851), // #45a7d9 periwinkle centre
        Color(red: 0.282, green: 0.565, blue: 0.863), // #4890dc blue right
        // fade row — sampled from original asset
        Color(red: 0.820, green: 0.965, blue: 0.957), // #d1f6f4
        Color(red: 0.882, green: 0.953, blue: 0.976), // #e1f3f9
        Color(red: 0.910, green: 0.950, blue: 0.980), // #e8f2fa
        // bottom row — white
        Color.white, Color.white, Color.white
    ]
    
    private let darkColors: [Color] = [
        // top row — sampled from original asset
        Color(red: 0.000, green: 0.075, blue: 0.102), // #00131a
        Color(red: 0.000, green: 0.071, blue: 0.141), // #001224
        Color(red: 0.004, green: 0.035, blue: 0.098), // #010919
        // mid row — sampled from original asset
        Color(red: 0.004, green: 0.533, blue: 0.612), // #01889c teal left
        Color(red: 0.004, green: 0.404, blue: 0.627), // #0167a0 centre
        Color(red: 0.008, green: 0.298, blue: 0.647), // #024ca5 blue right
        // fade row — sampled from original asset
        Color(red: 0.004, green: 0.133, blue: 0.125), // #012220
        Color(red: 0.004, green: 0.067, blue: 0.086), // #011116
        Color(red: 0.004, green: 0.051, blue: 0.090), // #010d17
        // bottom row — black
        Color.black, Color.black, Color.black
    ]
}

struct AuthenticationStartScreenBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationStartScreenBackgroundImage()
            .previewDisplayName("Light")
        AuthenticationStartScreenBackgroundImage()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
