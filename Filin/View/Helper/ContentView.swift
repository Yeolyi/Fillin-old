//
//  HabitListView.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var defaultTap: Int
    init(defaultTap: Int) {
        self._defaultTap = State(initialValue: defaultTap)
    }
    
    var body: some View {
        TabView(selection: $defaultTap) {
            HabitList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List".localized)
                }
                .tag(DefaultTap.list.rawValue)
            SummaryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Summary".localized)
                }
                .tag(DefaultTap.summary.rawValue)
            RoutineView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Routine".localized)
                }
                .tag(DefaultTap.routine.rawValue)
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting".localized)
                }
                .tag(DefaultTap.setting.rawValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(defaultTap: 0)
    }
}
