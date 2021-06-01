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
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
          .autocapitalization(.none)
        
        List(usedWords, id: \.self) {
          Image(systemName: "\($0.count).circle")
          Text($0)
        }
      }
      .navigationBarTitle(rootWord)
      .onAppear(perform: startGame)
    }
  }
  
  func addNewWord() {
    // Lowercase and trim the word, to make sure we
    // don't add duplicate words with case differences
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Exit if the remaining string is empty
    guard answer.count > 0 else { return }
    
    // Extra validation to come
    
    usedWords.insert(answer, at: 0)
    newWord = ""
  }
  
  func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      // 2. Load start.txt into a string
      if let startWords = try? String(contentsOf: startWordsURL) {
        // 3. Split the string up into an array of strings,
        // splitting on line breaks
        let allWords = startWords.components(separatedBy: "\n")
        
        // 4. Pick one random word, or use "silkworm" as a
        // sensible default
        rootWord = allWords.randomElement() ?? "silkworm"
        
        // If we are here everything has worked, so we can exit
        return
      }
    }
    
    // IF we are *here* then there was a problem -
    // trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
  }
  
  func isOriginal(word: String) -> Bool  {
    !usedWords.contains(word)
  }
  
  func isPossible(word: String) -> Bool {
    // Create a variable copy of the root word
    var tempWord = rootWord
    
    // Loop over each letter of the user's input word
    for letter in word {
      // See if that letter exists in our copy
      if let pos = tempWord.firstIndex(of: letter) {
        // If it does, we remove it from the copy
        // (so it can't be used twice), then continue
        tempWord.remove(at: pos)
      } else {
        return false
      }
    }
    // If we make it to the end of the user's word
    // successfully then the word is good
    return true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
