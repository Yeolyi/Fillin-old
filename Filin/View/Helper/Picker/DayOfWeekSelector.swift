//
//  DayOfWeekSelector.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/20.
//

import SwiftUI

struct DayOfWeekSelector: View {
    @Binding var dayOfTheWeek: [Int]
    @Environment(\.colorScheme) var colorScheme
    
    func isNextChecked(_ index: Int) -> Bool {
        dayOfTheWeek.contains(index) && dayOfTheWeek.contains(index + 1)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<8) { dayOfTheWeekInt in
                ZStack {
                    if dayOfTheWeek.contains(dayOfTheWeekInt) {
                        Rectangle()
                            .foregroundColor(ThemeColor.mainColor(colorScheme))
                    }
                    Text(Date.dayOfTheWeekShortStr(dayOfTheWeekInt))
                        .foregroundColor(dayOfTheWeek.contains(dayOfTheWeekInt) ? .white : .black)
                        .bodyText()
                }
                .frame(width: 44, height: 44)
                .zIndex(0)
                .onTapGesture {
                    if dayOfTheWeek.contains(dayOfTheWeekInt) {
                        dayOfTheWeek.remove(at: dayOfTheWeek.firstIndex(of: dayOfTheWeekInt)!)
                    } else {
                        dayOfTheWeek.append(dayOfTheWeekInt)
                    }
                }
            }
        }
    }
}

struct DayOfWeekSelector_Previews: PreviewProvider {
    
    struct PreviewWrapper: View {
        @State var dayOfWeek: [Int] = [1, 2, 3, 4, 5, 6, 7]
        var body: some View {
            DayOfWeekSelector(dayOfTheWeek: $dayOfWeek)
        }
    }
    static var previews: some View {
        PreviewWrapper()
    }
}
