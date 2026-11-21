//
// Copyright 2025 Element Creations Ltd.
// Copyright 2022-2025 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial.
// Please see LICENSE files in the repository root for full details.
//

import Compound
import SwiftUI

/// The Terms of Use the user must agree to before signing in or registering.
struct TermsAgreementScreen: View {
    let supportEmailAddress: String
    let supportURL: URL
    let termsURL: URL
    let onAgree: () -> Void
    let onDecline: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(UntranslatedL10n.screenTermsAgreementTitle)
                    .font(.compound.headingLGBold)
                    .foregroundColor(.compound.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text(UntranslatedL10n.screenTermsAgreementIntro)
                    .font(.compound.bodyMD)
                    .foregroundColor(.compound.textSecondary)
                
                Link(UntranslatedL10n.screenTermsAgreementFullTermsLink, destination: termsURL)
                    .font(.compound.bodyMD)
                    .foregroundColor(.compound.textLinkExternal)
                
                section(title: UntranslatedL10n.screenTermsAgreementToleranceTitle) {
                    Text(UntranslatedL10n.screenTermsAgreementToleranceMessage)
                }
                
                section(title: UntranslatedL10n.screenTermsAgreementReportingTitle) {
                    VStack(alignment: .leading, spacing: 8) {
                        bullet(UntranslatedL10n.screenTermsAgreementReportingReport)
                        bullet(UntranslatedL10n.screenTermsAgreementReportingBlock)
                        bullet(UntranslatedL10n.screenTermsAgreementReportingReview)
                    }
                }
                
                section(title: UntranslatedL10n.screenTermsAgreementContentTitle) {
                    Text(UntranslatedL10n.screenTermsAgreementContentMessage)
                }
                
                section(title: UntranslatedL10n.screenTermsAgreementContactTitle) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(UntranslatedL10n.screenTermsAgreementContactMessage)
                        Link(supportEmailAddress, destination: supportURL)
                            .foregroundColor(.compound.textLinkExternal)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .bottom, spacing: 0) { buttons }
        .background(Color.compound.bgCanvasDefault.ignoresSafeArea())
    }
    
    // MARK: - Private
    
    private var buttons: some View {
        VStack(spacing: 16) {
            Button(UntranslatedL10n.screenTermsAgreementAgreeButton, action: onAgree)
                .buttonStyle(.compound(.primary))
                .accessibilityIdentifier(A11yIdentifiers.termsAgreementScreen.agree)
            
            Button(UntranslatedL10n.screenTermsAgreementDeclineButton, action: onDecline)
                .buttonStyle(.compound(.tertiary))
                .accessibilityIdentifier(A11yIdentifiers.termsAgreementScreen.decline)
        }
        .padding(16)
        .background(Color.compound.bgCanvasDefault.ignoresSafeArea())
    }
    
    private func section(title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.compound.headingSMSemibold)
                .foregroundColor(.compound.textPrimary)
                .accessibilityAddTraits(.isHeader)
            
            content()
                .font(.compound.bodyMD)
                .foregroundColor(.compound.textSecondary)
        }
    }
    
    private func bullet(_ text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text("•")
                .accessibilityHidden(true)
            Text(text)
        }
    }
}

// MARK: - Previews

struct TermsAgreementScreen_Previews: PreviewProvider, TestablePreview {
    static var previews: some View {
        TermsAgreementScreen(supportEmailAddress: "support@theforestnetwork.earth",
                             supportURL: "mailto:support@theforestnetwork.earth",
                             termsURL: "https://theforestnetwork.earth/village/terms",
                             onAgree: { },
                             onDecline: { })
    }
}
