//
//  TopicNotes.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/18/24.
//

//import SwiftUI
//import SwiftData
//
//struct TopicNotes: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query var topics: [Topic]
//    
//    var body: some View {
//        if topics.isEmpty {
//            ContentUnavailableView(label: {
//                Label("No Topics available yet", systemImage: "doc.on.doc")
//            }, description: {
//                Text("Build an exam quiz to generate topics")
//            })
//            .preferredColorScheme(.dark)
//            .padding()
//            .offset(y: -100)
//        } else {
//            List {
//                ForEach(topics) { topic in
//                    NavigationLink(value: topic) {
//                        VStack(alignment: .leading) {
//                            Text(topic.name)
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
//                            Text(topic.generalOverview)
//                                .font(.headline)
//                                .foregroundStyle(.primary)
//                        }
//                        
//                    }
//                }
//                .onDelete(perform: deleteTopic)
//            }
//        }
//    }
//    
//    init(searchString: String = "") {
//        _topics = Query(filter: #Predicate { topic
//            in
//            true
//        })
//    }
//    
//    func deleteTopic(at offsets: IndexSet) {
//        for offset in offsets {
//            let topic = topics[offset]
//            modelContext.delete(topic)
//        }
//    }
//}
//
//#Preview {
//    TopicNotes()
//}
