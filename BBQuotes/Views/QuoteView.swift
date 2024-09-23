//
//  QuoteView.swift
//  BBQuotes
//
//  Created by chris on 2024/09/22.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    var body: some View {
        GeometryReader { geo in // for images sizes
                ZStack {
                    Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                        .resizable()
                        .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                    VStack{
                        VStack{
                            Spacer(minLength:   60)
                            switch vm.status {
                            case .notStarted:
                                EmptyView()
                            case .fetching:
                                ProgressView()
                            case .success:
                                Text("\"\(vm.quote.quote)\"")
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("txt-img-color"))
                                    .padding()
                                    .background(.black.opacity(0.5))
                                    .clipShape(.rect(cornerRadius: 25))
                                    .padding(.horizontal)
                                ZStack (alignment: .bottom) {
                                    AsyncImage(url: vm.character.images[0]) {image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                    Text(vm.quote.character)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color("txt-img-color"))
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.ultraThinMaterial)
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .clipShape(.rect(cornerRadius: 50))
                            case .failed(let error):
                                Text(error.localizedDescription)
                            }
                            
                            Spacer()
                        }
                        Button {
                            Task {
                                await vm.getData(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(Color("txt-img-color"))
                            .padding()
                            .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 3)
                        }
                        Spacer(minLength: 95)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
            }
                .frame(width: geo.size.width, height: geo.size.height)  // center the image
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    QuoteView(show: "Better Call Saul")
//    QuoteView(show: "Breaking Bad")
}
