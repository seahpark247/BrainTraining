//
//  ContentView.swift
//  BrainTraining
//
//  Created by Seah Park on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "brain")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Brain training!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
