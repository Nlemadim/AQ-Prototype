//
//  TopicsListView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

import SwiftUI

struct TopicsListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [Topic]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            TopicNotes(searchString: searchText)
                .navigationTitle("Topics").navigationBarTitleDisplayMode(.automatic)
                .navigationDestination(for: Topic.self) { topic in
                    TopicDetailsView()
                }
                .toolbar {
                    Button {
                        Task {
                            //MARK: Method to Add TopicNotes to QuizPlayer Playlist
                        }
                    }label: {
                        HStack(spacing: 5) {
                            Text("Create Playlist")
                                
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.teal)
                    }
    
                }
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    TopicsListView()
        .preferredColorScheme(.dark)
}
