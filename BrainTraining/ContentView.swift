//
//  ContentView.swift
//  BrainTraining
//
//  Created by Seah Park on 4/14/25.
//
// TODO: Add enum, refatoring winner function


import SwiftUI
//
//enum items: String, CaseIterable {
//    case rock = "rock"
//    case paper = "paper"
//    case scissors = "scissors"
//}

struct BackgroundColor: View {
    var body: some View {
        Color.clear.background(.green.gradient.opacity(0.8)).ignoresSafeArea()
    }
}

struct promptText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red).fontWeight(.bold)
    }
}

struct answerChoices: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.regularMaterial)
            .cornerRadius(20)
    }
}

struct statusText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
    }
}

extension View {
    func promptStyle() -> some View {
        modifier(promptText())
    }
    
    func answerStyle() -> some View {
        modifier(answerChoices())
    }
    
    func statusStyle() -> some View {
        modifier(statusText())
    }
}

struct ContentView: View {
//    @State private var item = items.allCases.randomElement()?.rawValue
    let gameItem = ["Rock", "Paper", "Sicissors"]
    @State private var index = Int.random(in: 0...2)
    @State private var brainTask = Bool.random()
    @State private var score = 0
    @State private var gameCount = 0
    @State private var content = ""
    @State private var showAlert: Bool = false
    
    // closure
    var symbol: String {
        switch index {
        case 0:
            return "✊"
        case 1:
            return "✋"
        default:
            return "✌️"
        }
    }
    
    // computed property
    var brainTaskText: String {
        brainTask ? "win" : "lose"
    }
    
    var body: some View {
        ZStack {
            BackgroundColor()
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Text("They play")
                        Text(symbol).font(.system(size: 200))
                    }
                    HStack {
                        Text("Tell me how to")
                        Text(brainTaskText).promptStyle()
                    }
                }.font(.title)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("I can")
                        Text(brainTaskText).promptStyle()
                        Text("if I play...")
                        
                        Spacer()
                    }.font(.title2)
                    
                    VStack {
                        ForEach(gameItem, id: \.self){ answer in
                            Button(answer) { winner(answer) }
                                .padding(.vertical, 4)
                        }
                    }
                    .answerStyle()

                }
                
                Spacer()
                
                HStack {
                    Text("Score: \(score)")
                    Spacer()
                    Text("Game Count: \(gameCount) / 10")
                }.statusStyle()
                                
                Spacer()
            }.alert(content, isPresented: $showAlert) {
                Button("OK") {
                    if gameCount == 10 {
                        playNew()
                    } else {
                        playContinue()
                    }
                }
            } message: {
                if gameCount == 10 {
                    Text("\(content), That was last game! Let's play again.")
                } else {
                    Text(content)
                }
            }
            .padding()
        }
    }
    
    func winner(_ answer: String) {
        let question = gameItem[index]
        
//        if your moves array was ["Rock", "Paper", "Scissors"] your array of winning moves would be ["Paper", "Scissors", "Rock"].
        
        if brainTaskText == "win" {
            if question == "Rock" && answer == "Paper" {
                win()
            } else if question == "Paper" && answer == "Sicissors" {
                win()
            } else if question == "Sicissors" && answer == "Rock" {
                win()
            } else {
                lose()
            }
        } else if brainTaskText == "lose" {
            if question == "Rock" && answer == "Sicissors" {
                win()
            } else if question == "Paper" && answer == "Rock" {
                win()
            } else if question == "Sicissors" && answer == "Paper" {
                win()
            } else {
                lose()
            }
        }
                
        gameCount += 1
        showAlert = true
    }
    
    func win() {
        content = "Got the point"
        score += 1
        return
    }
    
    func lose() {
        content = "Lost the point"
        score -= 1
        return
    }
    
    func playContinue() {
        index = Int.random(in: 0...2)
        brainTask.toggle()
    }
    
    func playNew() {
        playContinue()
        score = 0
        gameCount = 0
    }
}

#Preview {
    ContentView()
}
