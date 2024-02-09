//
//  SampleExam.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 2/1/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SampleExam: View {
    var featuredQuiz: FeaturedQuiz
    var questions: [Question]
    var playButtonAction: () -> Void

    var body: some View {
        ZStack { // Use ZStack to layer the image behind the content
            featuredQuiz.quizImage
                .resizable()
                .aspectRatio(contentMode: .fill) // Fill the available space
                .frame(height: 320.0) // Match the height of the container
                .cornerRadius(30)
                .blur(radius: 2) // Apply blur to the image
                .padding(.horizontal, 20) // Match the horizontal padding of the container

            VStack(alignment: .leading, spacing: 8.0) {
                Spacer()
                Button {
                    playButtonAction()
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26.0, height: 26.0)
                        .cornerRadius(10)
                        .padding(9)
                        .foregroundStyle(.teal)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }

                Text(featuredQuiz.quizName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))

                Text("\(featuredQuiz.questions.count) Questions".uppercased())
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)

                Text("Sample Audio Quiz")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2, reservesSpace: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.all, 20.0)
            .padding(.vertical, 20)
            .frame(height: 350.0)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply material effect on top of the image
            .shadow(radius: 10, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
        .preferredColorScheme(.dark)
        .overlay(
            featuredQuiz.quizImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(height: 130)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .offset(x: 32, y: -80)
        )
    }
}

#Preview {
    let featured = FeaturedQuiz.driversLicense
    return SampleExam2(featuredQuiz: featured, questions: featured.questions, playButtonAction: {})
}





struct SampleExam2: View {
    var featuredQuiz: FeaturedQuiz
    var questions: [Question]
    var playButtonAction: () -> Void

    var body: some View {
        ZStack { // Use ZStack to layer the image behind the content
            featuredQuiz.quizImage
                .resizable()
                .aspectRatio(contentMode: .fill) // Fill the available space
                .frame(height: 320.0) // Match the height of the container
                .cornerRadius(30)
                .blur(radius: 2) // Apply blur to the image
                .padding(.horizontal, 20) // Match the horizontal padding of the container

            VStack(alignment: .leading, spacing: 8.0) {
                Spacer()
                Button {
                    playButtonAction()
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26.0, height: 26.0)
                        .cornerRadius(10)
                        .padding(9)
                        .foregroundStyle(.teal)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }

                Text(featuredQuiz.quizName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))

                Text("\(featuredQuiz.questions.count) Questions".uppercased())
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)

                Text("Sample Audio Quiz")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2, reservesSpace: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.all, 20.0)
            .padding(.vertical, 20)
            .frame(height: 350.0)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous)) // Apply material effect on top of the image
            .shadow(radius: 10, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
        .preferredColorScheme(.dark)
        .overlay(
            featuredQuiz.quizImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(height: 150)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .offset(x: 32, y: -80)
        )
    }
}

struct AudioQuizView: View {
    var quiz: FeaturedQuiz

    var body: some View {
        VStack {
            quiz.quizImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 180, height: 260) // Adjusted size
                .cornerRadius(20)
                .overlay(
                    VStack {
                        Spacer()
                        // Encapsulate text within a background
                        VStack {
                            Text(quiz.quizName)
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .padding(5) // Adjust padding for text
                        }
                        .frame(width: 200, height: 60) // Fixed size background
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                    }
                    //.padding(.bottom, 10) // Adjust to ensure it aligns well within the image
                )
        }
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}



