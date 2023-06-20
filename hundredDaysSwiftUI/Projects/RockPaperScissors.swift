// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct RockPaperScissors: View {
    @State private var needsWin: Bool = Bool.random()
    @State private var computerMove: Int = Int.random(in: 0..<3)
    @State private var computerImageMove: String = "🤖"

    @State private var message: String = ""
    @State private var displayMessage: Bool = false

    private var moves = ["🪨", "📜", "✂️"]

    var body: some View {
        VStack {

            Spacer()

            Text("I have decided my move")
                .font(.largeTitle)

            Text(computerImageMove)
                .font(.system(size: 100))
                .padding()


            Text("Now is your turn.")
                .font(.largeTitle)
            Text("Select the one you need to \(needsWin ? "Win" : "Lose")!")
                .font(.largeTitle)

            HStack {
                ForEach(0..<3) { index in
                    Button(moves[index]) {
                        userSelected(index: index)
                    }
                    .font(.system(size: 100))
                    .padding()
                }
            }

            Spacer()
        }
        .alert(message, isPresented: $displayMessage) {
            Button("New Game", action: reset)
        }
    }

    func userSelected(index: Int) {

        computerImageMove = moves[computerMove]

        guard index != computerMove else {
            message = "That's a tie"

            displayMessage = true
            return
        }

        var winningPosition = computerMove + (needsWin ? 1 : -1)
        if winningPosition < 0 {
            winningPosition = 2
        } else if winningPosition > 2 {
            winningPosition = 0
        }

        message = index == winningPosition ? "You Win" : "You lose"

        displayMessage = true
    }

    func reset() {
        computerMove = Int.random(in: 0..<3)
        needsWin.toggle()
        computerImageMove = "🤖"
    }
}

struct RockPaperScissors_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissors()
    }
}
