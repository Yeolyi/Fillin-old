//
//  Main.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/11.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case diary, edit
    var id: Int {
        hashValue
    }
}

struct HabitViewMain: View {
    
    @EnvironmentObject var sharedViewData: SharedViewData
    @ObservedObject var habit: HabitInfo
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var activeSheet: ActiveSheet?
    @State var selectedDate = Date()
    @State var diaryExpanded = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if habit.explanation != nil {
                    HStack {
                        Spacer()
                        Text(habit.explanation!)
                            .font(.headline)
                        Spacer()
                    }
                    .rowBackground()
                }
                HStack {
                    Spacer()
                    CalendarRow(selectedDate: $selectedDate, habit: habit, isExpanded: sharedViewData.isCalendarMode)
                    Spacer()
                }
                .rowBackground()
                TodayHabit(habit: habit, selectedDate: $selectedDate)
                DiaryRow(activeSheet: $activeSheet, expanded: $diaryExpanded, habit: habit, selectedDate: selectedDate)
                    .padding(.bottom, 60)
            }
        }
        .padding(.top, 1)
        .navigationBarTitle(habit.name)
        .navigationBarItems(
            trailing:
                Button(action: { activeSheet = ActiveSheet.edit }) {
                    Text("편집")
                }
        )
        .sheet(item: $activeSheet) { item in
            switch(item) {
            case .diary:
                DiaryModal(habit: habit, targetDate: selectedDate)
                    .allowAutoDismiss(false)
            case .edit:
                AddHabit(targetHabit: habit)
                    .environment(\.managedObjectContext, managedObjectContext)
            }
        }
        .onAppear {
            withAnimation {
                sharedViewData.inMainView = false
            }
        }
        .onDisappear {
            withAnimation {
                sharedViewData.inMainView = true
            }
        }
    }
}


struct HabitViewMain_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return HabitViewMain(habit: .init(context: context))
            .environment(\.managedObjectContext, context)
    }
}
