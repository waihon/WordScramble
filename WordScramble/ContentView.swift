//
//  ContentView.swift
//  WordScramble
//
//  Created by Waihon Yew on 31/05/2021.
//

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        List(usedWords, id: \.self) {
          Text($0)
        }
      }
      .navigationBarTitle(rootWord)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
