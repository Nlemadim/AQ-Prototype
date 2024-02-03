//
//  FeaturedItems.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/1/24.


import Foundation
import SwiftUI
import SwiftData

enum FeaturedQuiz: Quiz {
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
                Question(id: UUID() ,questionContent: "What is required for a lawyer to avoid conflicts of interest with current clients?", questionNote: "", topic: "Professional Responsibility", options: ["A) Obtain informed consent, confirmed in writing.", "B) Ensure a physical separation from clients.", "C) Charge reasonable fees.", "D) Refer the client to another lawyer."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which amendment to the U.S. Constitution primarily deals with the rights of the accused in criminal cases?", questionNote: "", topic: "Constitutional Law", options: ["A) First Amendment", "B) Fourth Amendment", "C) Fifth Amendment", "D) Eighth Amendment"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What standard is used to determine the guilt of a defendant in a criminal trial?", questionNote: "", topic: "Criminal Law and Procedure", options: ["A) Preponderance of the evidence", "B) Clear and convincing evidence", "C) Beyond a reasonable doubt", "D) Probable cause"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is the primary purpose of the hearsay rule?", questionNote: "", topic: "Evidence", options: ["A) To ensure all evidence is relevant", "B) To allow witnesses to testify about what others said", "C) To exclude statements made out of court that are offered to prove the truth of the matter asserted", "D) To ensure direct evidence is presented"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What legal doctrine prevents the assertion of a property right by a possessor against the true owner after a certain period of time?", questionNote: "", topic: "", options: ["A) Rule against perpetuities", "B) Adverse possession", "C) Eminent domain", "D) Joint tenancy"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which of the following is a defense to a claim of negligence?", questionNote: "", topic: "Real Property", options: ["A) Vicarious liability", "B) Comparative negligence", "C) Assault", "D) Battery"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is required for a contract to be considered enforceable?", questionNote: "", topic: "Torts", options: ["A) An offer and an acceptance", "B) A written agreement", "C) Consideration", "D) Both A and C"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "Which of the following is a characteristic of a corporation but not a partnership?", questionNote: "Contracts", topic: "Business Associations", options: ["A) Limited liability for owners", "B) Pass-through taxation", "C) No formalities for creation", "D) Unlimited life"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What is required for a will to be valid?", questionNote: "", topic: "Wills and Trusts", options: ["A) Notarization", "B) Testator's signature and the signature of at least two witnesses", "C) A declaration of trust", "D) A beneficiary"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID() ,questionContent: "What principle requires a court to have the power to decide a case and make a binding decision on the parties involved?", questionNote: "", topic: "Civil Procedure", options: ["A) Subject matter jurisdiction", "B) Personal jurisdiction", "C) Venue", "D) Standing"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .mcat:
            return [
                Question(id: UUID(), questionContent: "Which of the following is a nucleotide?", questionNote: "", topic: "Biology", options: ["A) Adenine", "B) Ribose", "C) Phosphate", "D) Adenosine Triphosphate"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the primary function of the mitochondria?", questionNote: "", topic: "Biology", options: ["A) Protein synthesis", "B) Digestion", "C) ATP production", "D) DNA replication"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a fundamental particle of an atom?", questionNote: "", topic: "Chemistry", options: ["A) Proton", "B) Alpha particle", "C) Positron", "D) Photon"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the pH of a neutral solution at 25°C?", questionNote: "", topic: "Chemistry", options: ["A) 0", "B) 7", "C) 14", "D) 25"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a Newton's law of motion?", questionNote: "", topic: "Physics", options: ["A) Law of conservation of energy", "B) Law of universal gravitation", "C) Law of inertia", "D) Law of thermodynamics"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the speed of light in a vacuum?", questionNote: "", topic: "Physics", options: ["A) 3 x 10^8 m/s", "B) 3 x 10^9 m/s", "C) 3 x 10^10 m/s", "D) 3 x 10^11 m/s"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the primary function of the amygdala?", questionNote: "", topic: "Psychology", options: ["A) Memory formation", "B) Emotion processing", "C) Language production", "D) Sleep regulation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the defense mechanism in which unacceptable thoughts are pushed into the unconscious?", questionNote: "", topic: "Psychology", options: ["A) Projection", "B) Repression", "C) Displacement", "D) Sublimation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the term for the study of how people change physically, cognitively, and socially throughout the lifespan?", questionNote: "", topic: "Psychology", options: ["A) Psychopathology", "B) Developmental psychology", "C) Social psychology", "D) Cognitive psychology"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the term for the variable that is manipulated in an experiment?", questionNote: "", topic: "Research Methods", options: ["A) Dependent variable", "B) Independent variable", "C) Control variable", "D) Confounding variable"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .usCitizenship:
            return [
                Question(id: UUID(), questionContent: "Who is in charge of the executive branch?", questionNote: "", topic: "US Government", options: ["A) The President", "B) The Speaker of the House", "C) The Chief Justice", "D) The Majority Whip"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What do we call the first ten amendments to the Constitution?", questionNote: "", topic: "US Constitution", options: ["A) The inalienable rights", "B) The Articles of Confederation", "C) The Bill of Rights", "D) The Declaration of Independence"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "How many U.S. Senators are there?", questionNote: "", topic: "US Government", options: ["A) 50", "B) 100", "C) 435", "D) 538"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "We elect a U.S. Senator for how many years?", questionNote: "", topic: "US Government", options: ["A) 2", "B) 4", "C) 6", "D) 8"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Who signs bills to become laws?", questionNote: "", topic: "US Government", options: ["A) The Vice President", "B) The Secretary of State", "C) The President", "D) The Speaker of the House"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the capital of the United States?", questionNote: "", topic: "US Geography", options: ["A) New York", "B) Los Angeles", "C) Chicago", "D) Washington, D.C."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Who was the first President?", questionNote: "", topic: "US History", options: ["A) Abraham Lincoln", "B) George Washington", "C) Thomas Jefferson", "D) John Adams"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What did Martin Luther King, Jr. do?", questionNote: "", topic: "US History", options: ["A) Fought for women's suffrage", "B) Fought for civil rights", "C) Served as the second President", "D) Led the United States during World War I"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the supreme law of the land?", questionNote: "", topic: "US Constitution", options: ["A) The Declaration of Independence", "B) The Constitution", "C) The Emancipation Proclamation", "D) The Articles of Confederation"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is one right or freedom from the First Amendment?", questionNote: "", topic: "US Constitution", options: ["A) Right to bear arms", "B) Right to vote", "C) Freedom of speech", "D) Right to a fair trial"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
            ]
        case .gmats:
            return [
//                Question(id: UUID(), questionContent: "If x and y are positive, is x > y?", questionNote: "", topic: "Quantitative Reasoning", options: ["A) x^2 > y^2", "B) square root of x > square root of y", "C) Both A and B", "D) Neither A nor B"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")

                Question(id: UUID(), questionContent: "What is the sum of the first 100 positive integers?", questionNote: "", topic: "Quantitative Reasoning", options: ["A) 5050", "B) 5000", "C) 5100", "D) 5150"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "If a company sold 80 units at $500 per unit, what was the total revenue?", questionNote: "", topic: "Quantitative Reasoning", options: ["A) $30,000", "B) $40,000", "C) $50,000", "D) $60,000"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is an example of a metaphor?", questionNote: "", topic: "Verbal Reasoning", options: ["A) She is like a rose.", "B) She is a rose.", "C) She has a rose.", "D) She wants a rose."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following sentences is grammatically correct?", questionNote: "", topic: "Verbal Reasoning", options: ["A) I enjoys playing soccer.", "B) I enjoy playing soccer.", "C) I enjoying play soccer.", "D) I enjoyed to play soccer."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What is the meaning of the word 'abate'?", questionNote: "", topic: "Verbal Reasoning", options: ["A) To increase", "B) To decrease", "C) To remain constant", "D) To fluctuate"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following is a prime number?", questionNote: "", topic: "Quantitative Reasoning", options: ["A) 21", "B) 22", "C) 23", "D) 24"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
//                Question(id: UUID(), questionContent: "What is the area of a circle with a radius of 3?", questionNote: "", topic: "Quantitative Reasoning", options: ["A) \(6\pi\)", "B) \(9\pi\)", "C) \(12\pi\)", "D) \(18\pi\)"], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")
                Question(id: UUID(), questionContent: "What is the antonym of the word 'ascend'?", questionNote: "", topic: "Verbal Reasoning", options: ["A) Rise", "B) Climb", "C) Soar", "D) Descend"], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "Which of the following sentences is written in the passive voice?", questionNote: "", topic: "Verbal Reasoning", options: ["A) John ate the apple.", "B) The apple was eaten by John.", "C) John will eat the apple.", "D) John is eating the apple."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")

            ]
        case .driversLicense:
            return [
                Question(id: UUID(), questionContent: "When you see a school bus stopped with its red lights flashing and its stop arm extended, you must...", questionNote: "", topic: "Road Rules", options: ["A) Stop and wait until the red lights stop flashing and the stop arm is withdrawn.", "B) Pass if no children are present.", "C) Pass if you are on the opposite direction on a road with a median.", "D) Honk to alert the children."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a flashing yellow traffic signal mean?", questionNote: "", topic: "Traffic Signals and Signs", options: ["A) Stop", "B) Yield", "C) Proceed with caution", "D) The signal is broken"], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When you want to change lanes, you should...", questionNote: "", topic: "Safe Driving Practices", options: ["A) Signal your intentions and check your mirrors and blind spot.", "B) Signal and then move over quickly.", "C) Move over slowly without signaling.", "D) Honk your horn and move over."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do if another driver tailgates your vehicle?", questionNote: "", topic: "Safe Driving Practices", options: ["A) Speed up to increase the distance between you and the tailgater.", "B) Brake quickly to warn the driver.", "C) Move over to another lane or slowly reduce speed to encourage them to pass.", "D) Ignore the tailgater."], correctOption: "C", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a red traffic signal light mean?", questionNote: "", topic: "Traffic Signals and Signs", options: ["A) Stop", "B) Yield", "C) Caution", "D) Go"], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When are you allowed to drive above the speed limit?", questionNote: "", topic: "Road Rules", options: ["A) When other vehicles are driving above the speed limit.", "B) When you are passing another vehicle.", "C) When it seems safe to do so.", "D) You are never allowed to drive above the speed limit."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do when you approach a roundabout?", questionNote: "", topic: "Road Rules", options: ["A) Yield to pedestrians and any vehicles already in the roundabout.", "B) Enter the roundabout as quickly as possible.", "C) Stop completely before entering the roundabout.", "D) Honk your horn to alert other drivers."], correctOption: "A", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "When can you turn left on a red light?", questionNote: "", topic: "Traffic Signals and Signs", options: ["A) Never", "B) From a one-way street onto another one-way street.", "C) From a two-way street onto a one-way street.", "D) Whenever there are no approaching cars."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What does a solid yellow line on your side of the road mean?", questionNote: "", topic: "Road Markings", options: ["A) You may pass if it is safe to do so.", "B) You may not pass.", "C) You are in a no-passing zone.", "D) Both B and C."], correctOption: "D", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: ""),
                Question(id: UUID(), questionContent: "What should you do if your vehicle's right wheels leave the pavement?", questionNote: "", topic: "Emergency Situations", options: ["A) Stop quickly.", "B) Steer straight and slow down before attempting to return to the pavement.", "C) Accelerate and steer back onto the pavement.", "D) Brake hard and steer back onto the pavement."], correctOption: "B", selectedOption: "", isAnswered: false, isAnsweredCorrectly: false, numberOfPresentations: 0, questionAudio: "", questionNoteAudio: "")

            ]
        }
    }
}

extension FeaturedQuiz {
    static var allCases: [FeaturedQuiz] {
        return [.barExam, .mcat, .usCitizenship, .gmats, .driversLicense]
    }
}

