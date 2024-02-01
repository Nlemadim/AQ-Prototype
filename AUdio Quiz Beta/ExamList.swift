//
//  ExamList.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/31/24.
//

import SwiftUI
import SwiftData

struct ExamList: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = [ExamType]()
    @State private var searchText = ""
    //@Query(sort: \ExamType.name) var exams: [ExamType]
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    Exam()
                        .navigationTitle("Exam").navigationBarTitleDisplayMode(.automatic)
                        .navigationDestination(for: ExamType.self) { exam in
                            Text("Build Exam on this Screen\n\nAbout \(exam.name):\n\(exam.about)")
                        }
                        .searchable(text: $searchText)
                }
            }
            .preferredColorScheme(.dark)
            
            
        }
        .onAppear {
            Task {
                //await createExams()
            }
        }
    }
    
    func saveExamList() {
        UserDefaultsManager.saveArrayToUserDefaults(array: defaultExams, key: "defaultExams")
    }
    
    func createExams() async {
        saveExamList()
        
        let defaultList: [String] = UserDefaultsManager.getArrayFromUserDefaults(key: "defaultExams")
        
        defaultList.forEach { examName in
            let exam = ExamType(name: examName, about: "", imageUrl: "", category: "")
            modelContext.insert(exam)
            try! modelContext.save()
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
    ExamList()
        .modelContainer(for: [ExamType.self],
                        inMemory: true
        )
}
