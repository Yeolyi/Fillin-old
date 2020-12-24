//
//  SectionText.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/19.
//

import SwiftUI

/// Substitutes SwiftUI list section header
struct SectionText: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .font(.system(size: 21, weight: .bold))
                .padding(.top, 15)
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.bottom, 10)
    }
}

extension View {
    func sectionText() -> some View {
        return modifier(SectionText())
    }
}