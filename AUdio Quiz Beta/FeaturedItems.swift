//
//  FeaturedItems.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/1/24.


import Foundation
import SwiftUI
import SwiftData

enum FeaturedQuiz  {
    case barExam
    case mcat
    case usCitizenship
    case gmats
    case driversLicense
    
    var quizImage: Image {
        switch self {
        case .barExam:
            return Image("featuredBarExam")
        case .mcat:
            return Image("featuredMCAT1")
        case .usCitizenship:
            return Image("featuredUSCitizenship")
        case .gmats:
            return Image("featuredGMAT2")
        case .driversLicense:
            return Image("featuredDriversLicenseExam")
        }
    }
    
    var quizName: String {
        switch self {
        case .barExam:
            return "Practice Bar Exam"
        case .mcat:
            return "Practice MCATS"
        case .usCitizenship:
            return "Practice US Citizenship Exam"
        case .gmats:
            return "Practice GMATS"
        case .driversLicense:
            return "Practice Drivers License Test"
        }
    }
    
    var questions:  [Question] {
        switch self {
            
        case .barExam:
            return [
                Question(id: UUID() ,questionContent: "What is required for a lawyer to avoid conflicts of interest with current clients?", questionNote: "", topic: "Professional Responsibility", options: ["Obtain informed consent, confirmed in writing.", "Ensure a physical separation from clients.", "Charge reasonable fees.", "Refer the client to another lawyer."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which amendment to the U.S. Constitution primarily deals with the rights of the accused in criminal cases?", questionNote: "", topic: "Constitutional Law", options: ["First Amendment", "Fourth Amendment", "Fifth Amendment", "Eighth Amendment"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What standard is used to determine the guilt of a defendant in a criminal trial?", questionNote: "", topic: "Criminal Law and Procedure", options: ["Preponderance of the evidence", "Clear and convincing evidence", "Beyond a reasonable doubt", "Probable cause"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is the primary purpose of the hearsay rule?", questionNote: "", topic: "Evidence", options: ["To ensure all evidence is relevant", "To allow witnesses to testify about what others said", "To exclude statements made out of court that are offered to prove the truth of the matter asserted", "To ensure direct evidence is presented"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What legal doctrine prevents the assertion of a property right by a possessor against the true owner after a certain period of time?", questionNote: "", topic: "", options: ["Rule against perpetuities", "Adverse possession", "Eminent domain", "Joint tenancy"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which of the following is a defense to a claim of negligence?", questionNote: "", topic: "Real Property", options: ["Vicarious liability", "Comparative negligence", "Assault", "Battery"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is required for a contract to be considered enforceable?", questionNote: "", topic: "Torts", options: ["An offer and an acceptance", "A written agreement", "Consideration", "Both A and C"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which of the following is a characteristic of a corporation but not a partnership?", questionNote: "Contracts", topic: "Business Associations", options: ["Limited liability for owners", "Pass-through taxation", "No formalities for creation", "Unlimited life"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is required for a will to be valid?", questionNote: "", topic: "Wills and Trusts", options: ["Notarization", "Testator's signature and the signature of at least two witnesses", "A declaration of trust", "A beneficiary"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What principle requires a court to have the power to decide a case and make a binding decision on the parties involved?", questionNote: "", topic: "Civil Procedure", options: ["Subject matter jurisdiction", "Personal jurisdiction", "Venue", "Standing"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .mcat:
            return [
                Question(id: UUID(), questionContent: "Which of the following is a nucleotide?", questionNote: "", topic: "Biology", options: ["Adenine", "Ribose", "Phosphate", "Adenosine Triphosphate"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the primary function of the mitochondria?", questionNote: "", topic: "Biology", options: ["Protein synthesis", "Digestion", "ATP production", "DNA replication"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a fundamental particle of an atom?", questionNote: "", topic: "Chemistry", options: ["Proton", "Alpha particle", "Positron", "Photon"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the pH of a neutral solution at 25°C?", questionNote: "", topic: "Chemistry", options: ["0", "7", "14", "25"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a Newton's law of motion?", questionNote: "", topic: "Physics", options: ["Law of conservation of energy", "Law of universal gravitation", "Law of inertia", "Law of thermodynamics"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the speed of light in a vacuum?", questionNote: "", topic: "Physics", options: ["3 x 10^8 m/s", "3 x 10^9 m/s", "3 x 10^10 m/s", "3 x 10^11 m/s"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the primary function of the amygdala?", questionNote: "", topic: "Psychology", options: ["Memory formation", "Emotion processing", "Language production", "Sleep regulation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the defense mechanism in which unacceptable thoughts are pushed into the unconscious?", questionNote: "", topic: "Psychology", options: ["Projection", "Repression", "Displacement", "Sublimation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the term for the study of how people change physically, cognitively, and socially throughout the lifespan?", questionNote: "", topic: "Psychology", options: ["Psychopathology", "Developmental psychology", "Social psychology", "Cognitive psychology"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the term for the variable that is manipulated in an experiment?", questionNote: "", topic: "Research Methods", options: ["Dependent variable", "Independent variable", "Control variable", "Confounding variable"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .usCitizenship:
            return [
                Question(id: UUID(), questionContent: "Who is in charge of the executive branch?", questionNote: "", topic: "US Government", options: ["The President", "The Speaker of the House", "The Chief Justice", "The Majority Whip"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What do we call the first ten amendments to the Constitution?", questionNote: "", topic: "US Constitution", options: ["The inalienable rights", "The Articles of Confederation", "The Bill of Rights", "The Declaration of Independence"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "How many U.S. Senators are there?", questionNote: "", topic: "US Government", options: ["50", "100", "435", "538"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "We elect a U.S. Senator for how many years?", questionNote: "", topic: "US Government", options: ["2", "4", "6", "8"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Who signs bills to become laws?", questionNote: "", topic: "US Government", options: ["The Vice President", "The Secretary of State", "The President", "The Speaker of the House"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the capital of the United States?", questionNote: "", topic: "US Geography", options: ["New York", "Los Angeles", "Chicago", "Washington, D.C."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Who was the first President?", questionNote: "", topic: "US History", options: ["Abraham Lincoln", "George Washington", "Thomas Jefferson", "John Adams"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What did Martin Luther King, Jr. do?", questionNote: "", topic: "US History", options: ["Fought for women's suffrage", "Fought for civil rights", "Served as the second President", "Led the United States during World War I"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the supreme law of the land?", questionNote: "", topic: "US Constitution", options: ["The Declaration of Independence", "The Constitution", "The Emancipation Proclamation", "The Articles of Confederation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is one right or freedom from the First Amendment?", questionNote: "", topic: "US Constitution", options: ["Right to bear arms", "Right to vote", "Freedom of speech", "Right to a fair trial"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .gmats:
            return [
                Question(id: UUID(), questionContent: "What is the sum of the first 100 positive integers?", questionNote: "", topic: "Quantitative Reasoning", options: ["5050", "5000", "5100", "5150"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "If a company sold 80 units at $500 per unit, what was the total revenue?", questionNote: "", topic: "Quantitative Reasoning", options: ["$30,000", "$40,000", "$50,000", "$60,000"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is an example of a metaphor?", questionNote: "", topic: "Verbal Reasoning", options: ["She is like a rose.", "She is a rose.", "She has a rose.", "She wants a rose."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following sentences is grammatically correct?", questionNote: "", topic: "Verbal Reasoning", options: ["I enjoys playing soccer.", "I enjoy playing soccer.", "I enjoying play soccer.", "I enjoyed to play soccer."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the meaning of the word 'abate'?", questionNote: "", topic: "Verbal Reasoning", options: ["To increase", "To decrease", "To remain constant", "To fluctuate"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a prime number?", questionNote: "", topic: "Quantitative Reasoning", options: ["21", "22", "23", "24"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),

                Question(id: UUID(), questionContent: "What is the antonym of the word 'ascend'?", questionNote: "", topic: "Verbal Reasoning", options: ["Rise", "Climb", "Soar", "Descend"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following sentences is written in the passive voice?", questionNote: "", topic: "Verbal Reasoning", options: ["John ate the apple.", "The apple was eaten by John.", "John will eat the apple.", "John is eating the apple."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")

            ]
        case .driversLicense:
            return [
                Question(id: UUID(), questionContent: "When you see a school bus stopped with its red lights flashing and its stop arm extended, you must...", questionNote: "", topic: "Road Rules", options: ["Stop and wait until the red lights stop flashing and the stop arm is withdrawn.", "Pass if no children are present.", "Pass if you are on the opposite direction on a road with a median.", "Honk to alert the children."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a flashing yellow traffic signal mean?", questionNote: "", topic: "Traffic Signals and Signs", options: ["Stop", "Yield", "Proceed with caution", "The signal is broken"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When you want to change lanes, you should...", questionNote: "", topic: "Safe Driving Practices", options: ["Signal your intentions and check your mirrors and blind spot.", "Signal and then move over quickly.", "Move over slowly without signaling.", "Honk your horn and move over."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do if another driver tailgates your vehicle?", questionNote: "", topic: "Safe Driving Practices", options: ["Speed up to increase the distance between you and the tailgater.", "Brake quickly to warn the driver.", "Move over to another lane or slowly reduce speed to encourage them to pass.", "Ignore the tailgater."], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a red traffic signal light mean?", questionNote: "", topic: "Traffic Signals and Signs", options: ["Stop", "Yield", "Caution", "Go"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When are you allowed to drive above the speed limit?", questionNote: "", topic: "Road Rules", options: ["When other vehicles are driving above the speed limit.", "When you are passing another vehicle.", "When it seems safe to do so.", "You are never allowed to drive above the speed limit."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do when you approach a roundabout?", questionNote: "", topic: "Road Rules", options: ["Yield to pedestrians and any vehicles already in the roundabout.", "Enter the roundabout as quickly as possible.", "Stop completely before entering the roundabout.", "Honk your horn to alert other drivers."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When can you turn left on a red light?", questionNote: "", topic: "Traffic Signals and Signs", options: ["Never", "From a one-way street onto another one-way street.", "From a two-way street onto a one-way street.", "Whenever there are no approaching cars."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a solid yellow line on your side of the road mean?", questionNote: "", topic: "Road Markings", options: ["You may pass if it is safe to do so.", "You may not pass.", "You are in a no-passing zone.", "Both B and C."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do if your vehicle's right wheels leave the pavement?", questionNote: "", topic: "Emergency Situations", options: ["Stop quickly.", "Steer straight and slow down before attempting to return to the pavement.", "Accelerate and steer back onto the pavement.", "Brake hard and steer back onto the pavement."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")

            ]
        }
    }
}

extension FeaturedQuiz {
    static var allCases: [FeaturedQuiz] {
        return [.barExam, .mcat, .usCitizenship, .gmats, .driversLicense]
    }
}

