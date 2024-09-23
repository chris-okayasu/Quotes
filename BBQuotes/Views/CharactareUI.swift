//
//  CharactareUI.swift
//  BBQuotes
//
//  Created by chris on 2024/09/23.
//

import SwiftUI

struct CharactareUI: View {
    let character: Character
    let show: String
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .top){
                Image(show.lowercased().replacingOccurrences(of: " ", with:""))
                    .resizable()
                    .scaledToFit()
                
                ScrollView {
                    AsyncImage(url: character.images[0]) {image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                    .clipShape(.rect(cornerRadius: 25))
                    .padding(.top, 60)
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Portrayed By: \(character.portrayedBy)")
                            .font(.subheadline)
                        Divider()
                        Text("\(character.name) Info: ")
                        Text("Born: \(character.birthday)")
                        Divider()
                        Text("Occupations:\n" + character.occupations.map { "‣ \($0)" }.joined(separator: "\n"))
                            .font(.subheadline)
                        Divider()
                        if character.aliases.count > 0 {
                            Text("Nicknames: ")
                            Text("Occupations:\n" + character.aliases.map { "• \($0)" }.joined(separator: "\n"))
                                .font(.subheadline)
                            Divider()
                        }
                        
                        DisclosureGroup("Status (SPOILER ALERT!!!)"){
                            VStack(alignment: .leading){
                                if character.status == "Dead" {
                                    Text("💀 \(character.status)")
                                        .font(.title2)
                                } else {
                                    Text(character.status)
                                        .font(.title2)
                                }
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image) {image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text("How: ")
                                        .bold() +
                                    Text(death.details)
                                    
                                    Text("Last Words: ")
                                        .font(.subheadline) +
                                    Text("\"\(death.lastWords)\"")
                                        .font(.subheadline)
                                        .italic()
                                }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .tint(.primary)
                        
                    }
                    .frame(width: geo.size.width/1.5, alignment: .leading)
                    .padding(.bottom,50)
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
        .background(Color("bg-color"))
    }
}

#Preview {
    CharactareUI(character: ViewModel().character , show: "Breaking Bad")
}
