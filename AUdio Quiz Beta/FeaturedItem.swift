//
//  FeaturedItem.swift
//  AUdio Quiz Beta
//
//  Created by Tony Nlemadim on 1/19/24.
//

import Foundation
import SwiftUI

struct FeaturedItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Button {
                
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
            
            //.strokeStyle(cornerRadius: 16)
            Text("Practice New York Bar Exam")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("5 Questions".uppercased())
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
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
        .padding(.horizontal, 20)
        
        .overlay(
            //Image(systemName: "headphones")
            Image("Legal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(height: 130)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .offset(x: 32, y: -80)
        )
    }
}

struct SampleCustomExam: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15.0, height: 15.0)
                    .cornerRadius(10)
                    .padding(9)
                    .foregroundStyle(.teal)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            
            //.strokeStyle(cornerRadius: 16)
            Text("Sample Practice New York Bar Exam")
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2, reservesSpace: true)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("3 Questions".uppercased())
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
        .frame(width: 250, height: 180.0)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
        .padding(.horizontal, 20)

    }
}

