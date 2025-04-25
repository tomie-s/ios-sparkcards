//
//  ContentView.swift
//  SparkCards
//
//  Created by Tomi E. Salami on 2025-04-25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DeckListView()
                .tabItem {
                    Label("My Decks", systemImage: "book.fill")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
        }
    }
}

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                if searchText.isEmpty {
                    ContentUnavailableView(
                        "Search Decks",
                        systemImage: "magnifyingglass",
                        description: Text("Search for decks by name, topic, or content")
                    )
                } else {
                    List {
                        // Search results will go here
                        Text("Search results for: \(searchText)")
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search decks...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("User Name")
                                .font(.headline)
                            Text("user@example.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Statistics")) {
                    HStack {
                        Text("Total Cards Studied")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("101")
                    }
                    
                    HStack {
                        Text("Success Rate")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("87%")
                    }
                    
                    HStack {
                        Text("Study Streak")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("5 days")
                    }
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(destination: Text("Notification Settings")) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    
                    NavigationLink(destination: Text("Study Settings")) {
                        Label("Study Preferences", systemImage: "gear")
                    }
                    
                    NavigationLink(destination: Text("Appearance Settings")) {
                        Label("Appearance", systemImage: "paintbrush.fill")
                    }
                }
                
                Section {
                    Button(action: {}) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
