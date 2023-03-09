//
//  ContentView.swift
//  Countries
//
//  Created by Карина on 09.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["america", "argentina", "bangladesh", "brazil", "canada", "germany", "greece", "russia", "sweden", "united"].shuffled() // перемешивать
    
    @State private var currentAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Выберите флаг:")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[currentAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 8)
                
                    }
                }
                Text("Общий счет: \(score)")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text ("Общий счет:\(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }
    }
    
    func askQuestion() {
        countries.shuffled()
        currentAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == currentAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
