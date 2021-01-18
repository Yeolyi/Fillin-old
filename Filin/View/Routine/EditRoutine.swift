//
//  EditRoutine.swift
//  Fillin
//
//  Created by SEONG YEOL YI on 2020/12/26.
//

import SwiftUI

struct EditRoutine: View {
    
    let targetRoutine: RoutineContext
    
    @ObservedObject var tempRoutine: RoutineContext
    @ObservedObject var listData: ListData<UUID>
    
    @State var isReminderUsed: Bool
    @State var reminderTime: Date
    @State var isDeleteAlert = false
    
    @EnvironmentObject var routineManager: RoutineContextManager
    @EnvironmentObject var habitManager: HabitContextManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    init(routine: RoutineContext) {
        targetRoutine = routine
        tempRoutine = RoutineContext(copy: routine)
        if let time = routine.time {
            _isReminderUsed = State(initialValue: true)
            _reminderTime = State(initialValue: time)
        } else {
            _isReminderUsed = State(initialValue: true)
            _reminderTime = State(initialValue: Date())
        }
        listData = ListData<UUID>(values: routine.list.map(\.id), save: {_ in})
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text("\(tempRoutine.name)")
                            .headline()
                        Spacer()
                        HeaderText("Save".localized) {
                            tempRoutine.list = listData.sortedValue.compactMap{ id in
                                habitManager.contents.first(where: {$0.id == id})
                            }
                            tempRoutine.time = isReminderUsed ? reminderTime : nil
                            targetRoutine.update(to: tempRoutine)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(20)
                    Divider()
                }
                ScrollView {
                    VStack(spacing: 8) {
                            HStack {
                                Text("Name".localized)
                                    .bodyText()
                                Spacer()
                            }
                            .padding(.leading, 20)
                            .padding(.top, 20)
                            TextFieldWithEndButton("Drink water".localized, text: $tempRoutine.name)
                                .rowBackground()
                            HStack {
                                Text("List".localized)
                                    .bodyText()
                                Spacer()
                            }
                            .padding(.leading, 20)
                            NavigationLink(destination:
                                            RoutineSetList(listData: listData)
                                            .navigationBarTitle(Text(""), displayMode: .inline)
                            ) {
                                HStack {
                                    Text(String(format: NSLocalizedString("Consists of %d goals", comment: ""), tempRoutine.list.count))
                                        .bodyText()
                                    Spacer()
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .mainColor()
                            }
                            .rowBackground()
                        VStack {
                            HStack {
                                Text("Repeat")
                                    .bodyText()
                                Spacer()
                            }
                            DayOfWeekSelector(dayOfTheWeek: $tempRoutine.dayOfWeek)
                        }
                        .rowPadding()
                        VStack {
                            HStack {
                                Text("Use reminder".localized)
                                    .bodyText()
                                Spacer()
                                if isReminderUsed {
                                    DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .accentColor(ThemeColor.mainColor(colorScheme))
                                }
                                PaperToggle($isReminderUsed)
                            }
                        }
                        .rowBackground()
                        Button(action: {self.isDeleteAlert = true}) {
                            Text("Delete".localized)
                                .foregroundColor(.red)
                                .bodyText()
                        }
                        .frame(minWidth: 44, minHeight: 22)
                        .alert(isPresented: $isDeleteAlert) { deleteAlert }
                        .padding(.vertical, 30)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    var deleteAlert: Alert {
        Alert(
            title: Text(String(format: NSLocalizedString("Delete %@?", comment: ""), tempRoutine.name)),
            message: nil,
            primaryButton: .default(Text("Cancel".localized)),
            secondaryButton: .destructive(Text("Delete".localized), action: {
                routineManager.deleteObject(id: targetRoutine.id)
                presentationMode.wrappedValue.dismiss()
            }))
    }
}

/*
struct EditRoutine_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataPreview = CoreDataPreview.shared
        EditRoutine(routine: coreDataPreview.sampleRoutine(name: "Default", dayOfTheWeek: [1, 2, 3, 4], time: "12-03"))
            .environment(\.managedObjectContext, coreDataPreview.context)
    }
}
*/
