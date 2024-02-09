//
//  DefaultAudioQuizCollection.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/9/24.
//

import Foundation

enum DefaultAudioQuizCollection: String, CaseIterable {
    case californiaBar = "California Bar"
    case mcat = "MCAT"
    case usmleStep1 = "USMLE Step 1"
    case cpaExam = "CPA Exam"
    case nclexRN = "NCLEX-RN"
    case pmpExam = "PMP Exam"
    case lsat = "LSAT"
    case comptiaAPlus = "CompTIA A+"
    case peExam = "PE Exam"
    case cfpExam = "CFP Exam"
    case baristaCertification = "Barista Certification"
    case realEstateLicensingExam = "Real Estate Licensing Exam"
    case architectRegistrationExam = "Architect Registration Exam"
    case series7Exam = "Series 7 Exam"
    case gre = "GRE (Graduate Record Examination)"
    case toefl = "TOEFL (Test of English as a Foreign Language)"
    case gmat = "GMAT (Graduate Management Admission Test)"
    case cfa = "CFA (Chartered Financial Analyst) Exam"
    case ccna = "CCNA (Cisco Certified Network Associate) Exam"
    case bptc = "Bar Professional Training Course (BPTC)"
    case mccqe = "Medical Council of Canada Qualifying Exam (MCCQE)"
    case cehExam = "Certified Ethical Hacker (CEH) Exam"
    case cisspExam = "Certified Information Systems Security Professional (CISSP) Exam"
    case csmExam = "Certified ScrumMaster (CSM) Exam"
    case cssgbExam = "Certified Six Sigma Green Belt (CSSGB) Exam"
    case cisaExam = "Certified Information Systems Auditor (CISA) Exam"
    case nce = "National Counselor Examination for Licensure and Certification (NCE)"
    case ncmhce = "National Clinical Mental Health Counseling Examination (NCMHCE)"
    case swiftProgrammingLanguage = "Swift Programming Language"
}

extension DefaultAudioQuizCollection {
    static var allCases: [DefaultAudioQuizCollection] {
        return [.californiaBar, .mcat, .usmleStep1, .cpaExam, .nclexRN, .pmpExam, .lsat, .comptiaAPlus, .peExam, .cfpExam, .baristaCertification, .realEstateLicensingExam, .architectRegistrationExam, .series7Exam, .gre, .toefl, .gmat, .cfa, .ccna, .bptc, .mccqe, .cehExam, .cisspExam, .csmExam, .cssgbExam, .cisaExam, .nce, .ncmhce, .swiftProgrammingLanguage]
    }
}


