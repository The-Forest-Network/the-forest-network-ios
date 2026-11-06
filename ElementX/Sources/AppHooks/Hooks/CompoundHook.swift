//
// Copyright 2025 Element Creations Ltd.
// Copyright 2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

nonisolated protocol CompoundHookProtocol: Sendable {
    @MainActor func override(colors: CompoundColors, uiColors: CompoundUIColors)
}

struct DefaultCompoundHook: CompoundHookProtocol {
    // #6e765d — The Forest Network primary brand colour and its derived shades.
    private static let brandRest = Color(red: 0.431, green: 0.463, blue: 0.365) // #6e765d
    private static let brandHovered = Color(red: 0.376, green: 0.404, blue: 0.318) // #606751 (~13% darker)
    private static let brandPressed = Color(red: 0.325, green: 0.349, blue: 0.275) // #535946 (~25% darker)
    private static let brandLight = Color(red: 0.545, green: 0.569, blue: 0.490) // #8b917d (~20% lighter)
    private static let brandSelected = brandRest.opacity(0.11)
    
    // #535946 — Darker shade used for primary CTA buttons (better white-text contrast).
    private static let ctaRest = Color(red: 0.325, green: 0.349, blue: 0.275) // #535946
    private static let ctaHovered = Color(red: 0.282, green: 0.302, blue: 0.239) // #484d3d (~13% darker)
    private static let ctaPressed = Color(red: 0.243, green: 0.263, blue: 0.208) // #3e4335 (~25% darker)
    
    func override(colors: CompoundColors, uiColors: CompoundUIColors) {
        colors.override(\.bgAccentRest, with: Self.brandRest)
        colors.override(\.bgAccentHovered, with: Self.brandHovered)
        colors.override(\.bgAccentPressed, with: Self.brandPressed)
        colors.override(\.bgAccentSelected, with: Self.brandSelected)
        colors.override(\.borderAccentPrimary, with: Self.brandRest)
        colors.override(\.borderAccentSubtle, with: Self.brandLight)
        colors.override(\.iconAccentPrimary, with: Self.brandRest)
        colors.override(\.iconAccentTertiary, with: Self.brandLight)
        colors.override(\.textActionAccent, with: Self.brandRest)
        colors.override(\.bgBadgeAccent, with: Self.brandRest)
        colors.override(\.textBadgeAccent, with: Self.brandPressed)
        colors.override(\.bgActionPrimaryRest, with: Self.ctaRest)
        colors.override(\.bgActionPrimaryHovered, with: Self.ctaHovered)
        colors.override(\.bgActionPrimaryPressed, with: Self.ctaPressed)
    }
}
