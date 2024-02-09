//
//  Exam.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/31/24.
//

import SwiftUI
import SwiftData

struct Exam: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \AudioQuizPackage.name) var exams: [AudioQuizPackage]
    
    var body: some View {
        if exams.isEmpty {
            ContentUnavailableView(label: {
                Label("List is Unavailable", systemImage: "doc.on.doc")
            }, description: {
                Text("Download exam list to see collection")
            }, actions: {
                Button("Download") { Task { await createExams()}}
                    .foregroundStyle(.teal)
            })
            .preferredColorScheme(.dark)
            .padding()
            .offset(y: -100)
        } else {
            List {
                ForEach(exams) { exam in
                    NavigationLink(value: exam) {
                        VStack(alignment: .leading) {
                            Text(exam.name)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .lineLimit(2, reservesSpace: true)
                                .multilineTextAlignment(.leading)
//                            Text(exam.about)
//                                .font(.headline)
//                                .foregroundStyle(.primary)
                        }
                    }
                    .listRowSeparator(.automatic)
                    .listRowBackground(Color.clear)
                }
            }
        } 
    }
    
//    init(searchString: String = "") {
//        _exams = Query(filter: #Predicate { exam
//            in
//            true
//        })
//    }
    
    func saveExamList() {
        UserDefaultsManager.saveArrayToUserDefaults(array: defaultExams, key: "defaultExams")
    }
    
    func createExams() async {
        if exams.isEmpty {
            saveExamList()
            
            let defaultList: [String] = UserDefaultsManager.getArrayFromUserDefaults(key: "defaultExams")
            
            defaultList.forEach { examName in
                let exam = AudioQuizPackage(id: UUID(), name: examName, about: "", imageUrl: "", category: "")
                modelContext.insert(exam)
                try! modelContext.save()
            }
        } else {
             return
        }
    }
    
    var defaultExams: [String] = [
        "California Bar",
        "MCAT",
        "USMLE Step 1",
        "CPA Exam",
        "NCLEX-RN",
        "PMP Exam",
        "LSAT",
        "CompTIA A+",
        "PE Exam",
        "CFP Exam",
        "Barista Certification",
        "Real Estate Licensing Exam",
        "Architect Registration Exam",
        "Series 7 Exam",
        "GRE (Graduate Record Examination)",
        "TOEFL (Test of English as a Foreign Language)",
        "GMAT (Graduate Management Admission Test)",
        "CFA (Chartered Financial Analyst) Exam",
        "CCNA (Cisco Certified Network Associate) Exam",
        "Bar Professional Training Course (BPTC)",
        "Medical Council of Canada Qualifying Exam (MCCQE)",
        "Certified Ethical Hacker (CEH) Exam",
        "Certified Information Systems Security Professional (CISSP) Exam",
        "Certified ScrumMaster (CSM) Exam",
        "Certified Six Sigma Green Belt (CSSGB) Exam",
        "Certified Information Systems Auditor (CISA) Exam",
        "National Counselor Examination for Licensure and Certification (NCE)",
        "National Clinical Mental Health Counseling Examination (NCMHCE)",
        "Swift Programming Language"
    ]
}

#Preview {
    Exam()
        
}
