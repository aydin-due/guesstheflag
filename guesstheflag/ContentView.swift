//
//  ContentView.swift
//  guesstheflag
//
//  Created by aydin salman on 20/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var showingScore = false
    @State var scoreTitle = ""
    @State var score = 0
    @State var round = 0
    
    func flagTapped(_ number: Int) {
        print(round)
        round += 1
        if (number == correctAnswer){
            scoreTitle = "right"
            score += 1
        } else {
            scoreTitle = "wrong, that's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func reset(){
        round = 0
        score = 0
        askQ()
    }
    
    func askQ(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("guess the flag!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                        
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 50)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            round == 8
            ? Button("restart", action: reset)
            : Button("continue", action: askQ)
        } message: {
            Text("your score is \(score)")
        }
        
    }
}

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
