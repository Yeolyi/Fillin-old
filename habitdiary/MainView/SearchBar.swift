//
//  SearchBar.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/11.
//


import SwiftUI

/// Searchbar containing magnifying glass symbol and text clear feature.
struct SearchBar: View {
    
    @State var searchWord = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("메뉴 이름을 검색하세요", text: $searchWord)
            // When text exists, show delete button.
            if searchWord != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.searchWord = ""
                        }
                    }
            }
        }
        .foregroundColor(.secondary)
        .rowBackground()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}