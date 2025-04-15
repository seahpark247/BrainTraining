//
//  ContentView.swift
//  BrainTraining
//
//  Created by Seah Park on 4/14/25.
//
// TODO: 러프하게 만들기 -> 리팩토링


import SwiftUI
//
//enum items: String, CaseIterable {
//    case rock = "rock"
//    case paper = "paper"
//    case scissors = "scissors"
//}

struct ContentView: View {
//    @State private var item = items.allCases.randomElement()?.rawValue
    @State private var gameItem = ["Rock", "Paper", "Sicissors"].shuffled()
    @State private var index = Int.random(in: 0...2)
    @State private var winFlip = false
    @State private var showAlert: Bool = false
    @State private var content = ""
    @State private var score = 0
    @State private var statusItem = ["win", "lose"].shuffled()
    @State private var statusIndex = Int.random(in: 0...1)
    @State private var gameCount = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            //            Text("✌️✊✋").font(.largeTitle)
            Text("Here is \(gameItem[index])")
            Text("Tell me how to \(statusItem[statusIndex])")
            
            Spacer()
            
            VStack {
                Text("I can \(statusItem[statusIndex]) if I play...")
                Button("Rock") {
                    winner(answer: "Rock")
                }
                Button("Paper") {
                    winner(answer: "Paper")
                }
                Button("Sicissors") {
                    winner(answer: "Sicissors")
                }
            }
            Text("Score: \(score), game count: \(gameCount) / 10")
            
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
        
    }
    
    func winner(answer: String) {
        var question = gameItem[index]
        
        if statusItem[statusIndex] == "win" {
            if question == "Rock" && answer == "Paper" {
                win()
            } else if question == "Paper" && answer == "Sicissors" {
                win()
            } else if question == "Sicissors" && answer == "Rock" {
                win()
            } else {
                lose()
            }
        } else if statusItem[statusIndex] == "lose" {
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
        gameItem.shuffle()
        statusIndex = Int.random(in: 0...1)
        statusItem.shuffle()
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
