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
        // top row — 90% toward white
        Color(red: 0.945, green: 0.918, blue: 0.929), // plum tint
        Color(red: 0.955, green: 0.947, blue: 0.924), // blend
        Color(red: 0.976, green: 0.965, blue: 0.918), // gold tint
        // mid row — brand colours
        Color(red: 0.463, green: 0.180, blue: 0.267), // #762e44 red wine plum left
        Color(red: 0.541, green: 0.396, blue: 0.220), // #8a6538 amber centre
        Color(red: 0.769, green: 0.627, blue: 0.188), // #c4a030 gold right
        // fade row — 90% toward white
        Color(red: 0.945, green: 0.918, blue: 0.929), // plum tint
        Color(red: 0.955, green: 0.947, blue: 0.924), // blend
        Color(red: 0.976, green: 0.965, blue: 0.918), // gold tint
        // bottom row — white
        Color.white, Color.white, Color.white
    ]
    
    private let darkColors: [Color] = [
        // top row — 90% toward black
        Color(red: 0.047, green: 0.020, blue: 0.027), // plum tint
        Color(red: 0.054, green: 0.044, blue: 0.025), // blend
        Color(red: 0.078, green: 0.063, blue: 0.020), // gold tint
        // mid row — brand colours at 70% brightness
        Color(red: 0.325, green: 0.125, blue: 0.188), // #532030 dark red wine left
        Color(red: 0.380, green: 0.278, blue: 0.154), // #614722 dark amber centre
        Color(red: 0.537, green: 0.439, blue: 0.133), // #897022 dark gold right
        // fade row — 90% toward black
        Color(red: 0.047, green: 0.020, blue: 0.027), // plum tint
        Color(red: 0.054, green: 0.044, blue: 0.025), // blend
        Color(red: 0.078, green: 0.063, blue: 0.020), // gold tint
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
