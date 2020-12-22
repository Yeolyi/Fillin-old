//
//  Test3.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/13.
//

import SwiftUI

struct TimesSection: View {
    @Binding var number: String
    var body: some View {
        HabitAddBadgeView(title: "Times setting".localized, imageName: "textformat.123") {
            Text("Times".localized)
                .sectionText()
            TextFieldWithEndButton("15", text: $number)
                .keyboardType(.numberPad)
            .padding([.leading, .trailing], 10)
        }
        //.keyboardTouchAreaBackground()
    }
}

struct Test3_Previews: PreviewProvider {
    static var previews: some View {
        TimesSection(number: .constant("15"))
    }
}
