//
//  TopicsListView.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

//import SwiftUI
//import SwiftData
//
//struct TopicsListView: View {
//    @Environment(\.modelContext) private var modelContext
//    @State private var path = [Topic]()
//    @Query(sort: \Topic.name) var topics: [Topic]
//    @State private var searchText = ""
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            ZStack {
//                VStack {
//                    TopicNotes(searchString: searchText)
//                        .navigationTitle("Topics").navigationBarTitleDisplayMode(.automatic)
//                        .navigationDestination(for: Topic.self) { topic in
//                            TopicDetailsView()
//                        }
//                        .searchable(text: $searchText)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    TopicsListView()
//        .preferredColorScheme(.dark)
//}
