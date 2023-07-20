import SwiftUI

struct Scramble: View {
    private static let words = allWords.components(separatedBy: "\n")
    
    @State private var wordTable = [Character:Int]()
    
    @State private var unusedWords: [String] = []
    @State private var word = words.randomElement() ?? "silkworm"
    @State private var userInput = ""
    @State private var usedWords: [String] = []
    
    @State private var message: String = ""
    @State private var isMessageShown: Bool = false
    @State private var score: Int = 0
    
    var body: some View {
        NavigationView { 
            VStack {
                
                Form {
                    Section("Make words from -> \(word)") {
                        HStack {
                            TextField("", text: $userInput)
                                .textInputAutocapitalization(.never)
                            Button("Verify", action: addNewWord)
                                .foregroundColor(Color.white.opacity(0.8))
                                .padding()
                        }
                    }
                    
                    Section("Used words") {
                        List {
                            ForEach(usedWords, id: \.self) { word in
                                HStack {
                                    Image(systemName: "\(word.count).circle")
                                    Text(word)
                                }
                            }
                        }
                    }
                }
                .onSubmit(addNewWord)
                .alert("Error", isPresented: $isMessageShown) {
                    Button("OK", action: {})
                } message: {
                    Text(message)
                        .foregroundColor(.white)
                }
                .onAppear(perform: newGame)
                .navigationTitle("Scramble")
                .toolbar(.visible, for: .navigationBar)
                .toolbar {
                    Button("New Game", action: newGame)
                }
                
                Divider()
                
                Text("Score \(score)")
            }
        }
    }
    
    func addNewWord() {
        let userWord = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard userWord.count >= 3 else {
            message = "The word should not have less than 3 letters"
            isMessageShown = true
            return
        }
        
        guard !userWord.isEmpty && userWord.count <= word.count else {
            message = "The word should not have more than \(word.count) characters"
            isMessageShown = true
            return
        }
        
        guard userWord != word else {
            message = "The word should not be the root"
            isMessageShown = true
            return
        }
        
        guard !usedWords.contains(userWord) else {
            message = "Word already used"
            isMessageShown = true
            userInput = ""
            return
        }
        
        guard isValidWord(newWord: userWord) else {
            message = "That's not a valid word"
            isMessageShown = true
            return
        }
        
        
        guard isContained(userWord) else {
            message = "That's not a valid word"
            isMessageShown = true
            return
        }
        
        withAnimation {
            usedWords.insert(userWord, at: 0)
            userInput = ""
        }
        
        score = score + userWord.count
    }
    
    func isContained(_ newWord: String) -> Bool {
        var tableCopy = wordTable
        for w in newWord {
            let charCount = (tableCopy[w] ?? 0) - 1
            
            guard charCount >= 0 else {
                return false
            }
            tableCopy[w] = charCount
        }
        
        return true
    }
    
    func isValidWord(newWord: String) -> Bool {
        let checker = UITextChecker()
        let validWord = checker.rangeOfMisspelledWord(in: newWord, range: NSRange(location: 0, length: newWord.count), startingAt: 0, wrap: false, language: Locale.current.identifier)
        
        return validWord.location == NSNotFound
    }
    
    func newGame() {
        unusedWords = unusedWords.isEmpty ? Self.words : unusedWords
        
        if !word.isEmpty {
            let indexOfWord = unusedWords.firstIndex(of: word) ?? 0
            unusedWords.remove(at: indexOfWord)
        }
        word = unusedWords.randomElement() ?? "silkworm"
        userInput = ""
        usedWords.removeAll(keepingCapacity: false)
        wordTable = [:]
       
        for w in word {
            wordTable[w] = wordTable[w] == nil ? 1 : wordTable[w]! + 1
        }
        
    }
}
