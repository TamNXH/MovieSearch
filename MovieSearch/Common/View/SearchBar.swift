//
//  SearchBar.swift
//
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
    @FocusState private var searchIsFocused: Bool

    var body: some View {
        VStack {
            if isEditing {
                Text("Movie List")
                    .bold()
                    .font(.system(size: 36))
                    .padding(.leading, 20)
            }
            HStack {
                if isEditing {
                    HStack {
                        TextField("Search ...", text: $text)
                            .padding(7)
                            .padding(.horizontal, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .focused($searchIsFocused)
                            .onTapGesture {
                                withAnimation {
                                    isEditing = true
                                }
                            }
                            Button(action: {
                                withAnimation {
                                    isEditing = false
                                    searchIsFocused = false
                                }
                            }) {
                                Text("Cancel")
                            }
                            .padding(.trailing, 20)
                    }
                    .transition(.move(edge: .trailing))
                } else {
                    Text("Movie List")
                        .bold()
                        .font(.system(size: 36))
                        .padding(.leading, 20)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.blue)
                        .frame(width: 36, height: 36)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            withAnimation {
                                isEditing = true
                            }
                        }.transition(.move(edge: .trailing))
                }

            }
        }
    }
}
