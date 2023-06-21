// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct RockPaperScissors: View {
    @State private var needsWin: Bool = Bool.random()
    @State private var computerMove: Int = Int.random(in: 0..<3)
    @State private var computerImageMove: String = "🤖"

    @State private var message: String = ""
    @State private var displayMessage: Bool = false

    @State private var score: Int = 0
    @State private var userWins: Bool = false

    private var moves = ["🪨", "📜", "✂️"]
    private var feedbackOptions = ["😵", "😁", "😐"]

    var body: some View {

        ZStack {

            LinearGradient(colors: [.green, .blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {

                Spacer()

                Text("I have decided my move")
                    .font(.largeTitle)

                Text(computerImageMove)
                    .font(.system(size: 100))
                    .padding()
                    .animation(.default, value: computerImageMove)

                Text("Now is your turn.")
                    .font(.largeTitle)
                Text("Select the one you need to \(needsWin ? "Win" : "Lose")!")
                    .font(.largeTitle)

                Spacer()

                HStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        Button(moves[index]) {
                            userSelected(index: index)
                        }
                        .font(.system(size: 90))
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 10)
                        .shadow(radius: 10)
                    }
                }

                Spacer()

                Text("Score: \(score)")

                Spacer()
            }

            VStack {
                Spacer()

                Button(message, action: reset)
                    .leveled()
                    .font(.system(size: 300))
                    .opacity(displayMessage ? 1 : 0)
            }

        }
    }

    func userSelected(index: Int) {

        computerImageMove = moves[computerMove]

        guard index != computerMove else {
            message = feedbackOptions[2]

            displayMessage = true
            return
        }

        var winningPosition = computerMove + (needsWin ? 1 : -1)
        if winningPosition < 0 {
            winningPosition = 2
        } else if winningPosition > 2 {
            winningPosition = 0
        }

        message = feedbackOptions[index == winningPosition ? 1 : 0]

        score = score + (index == winningPosition ? 1 : 0)
        displayMessage = true
    }

    func reset() {
        computerMove = Int.random(in: 0..<3)
        needsWin.toggle()
        computerImageMove = "🤖"
        message = ""
        displayMessage.toggle()
    }
}

struct RockPaperScissors_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissors()
    }
}
