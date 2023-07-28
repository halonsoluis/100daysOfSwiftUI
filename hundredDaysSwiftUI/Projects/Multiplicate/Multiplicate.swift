// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

///Appealing idea..
///
///Make recordigns of previous games of the person, in terms of time per question.
///Then, in dependence of the difficulty provide a value to use to increase the empire.
///For now, empire can be red vs blue. even more colors could apply.
///
///- remember the ones you faul often.

struct Multiplicate: View {

   var allMultiplicationTables = Array(2...12)

    @State var multiplicationTables = Set<Int>()
    @State var questionsToAnswer: Int = 10

    @FocusState private var answerIsFocused: Bool
    @State var leftOperand = 7
    @State var rightOperand = 7
    @State var answer: String = ""
    @State var previousAnswers = [(expression: String, correct: Bool)]()

    private let questionsToAsk: [Int] = [5, 10, 15]

    @State var isReady: Bool = false
    @State var gameEnded: Bool = false
    @State var gameStarted: Bool = false

    var isCorrectAnswer: Bool {
        rightAnswer == Int(answer)
    }

    var rightAnswer: Int {
        leftOperand * rightOperand
    }

    var body: some View {

        ZStack {
            List {
                ForEach(previousAnswers, id: \.self.expression) {
                    Text($0.expression)
                        .foregroundColor($0.correct ? .green : .red)
                }
            }

            Form {
                Section("How many questions to ask?") {
                    Picker("amount", selection: $questionsToAnswer) {
                        ForEach(questionsToAsk, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("What tables to ask from?") {
                    List(allMultiplicationTables, id: \.self) { table in

                            Label {
                                Text(table.description)
                            } icon: {
                                Image(
                                    systemName: multiplicationTables.contains(table)
                                    ? "circle.fill"
                                    : "circle"
                                )
                            }
                            .onTapGesture {
                                if multiplicationTables.contains(table) {
                                    multiplicationTables.remove(table)
                                } else {
                                    multiplicationTables.insert(table)
                                }
                            }
                    }
                }

                Section("Ready to Start?") {
                    Button("Yes") {
                        isReady = true
                        gameStarted = true
                        createProblem()
                    }
                }
                .opacity(!multiplicationTables.isEmpty ? 1 : 0)
            }
            .opacity(isReady || gameStarted ? 0 : 1)

            HStack(alignment: .center) {
                Group {
                    Text(leftOperand, format: .number)
                    Text("x")
                    Text(rightOperand, format: .number)
                    Text(" = ")

                    TextField("  ? ", text: $answer)
                        .keyboardType(.numberPad)
                        .labelsHidden()
                        .focused($answerIsFocused)
                        .frame(width: 50)
                }
                .font(.largeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.orange)
                )
                .opacity(isReady && gameStarted && !gameEnded ? 1 : 0)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()

                    Button("Done") {
                        if let answer = Int(answer) {
                            let item = (
                                expression: "\(leftOperand) x \(rightOperand) = \(answer)",
                                correct: isCorrectAnswer
                            )
                            previousAnswers.insert(item, at: 0)
                        }

                        nextQuestion()
                    }
                }

            }

        }
    }

    private func nextQuestion() {
        questionsToAnswer = questionsToAnswer - 1
        gameEnded = questionsToAnswer < 1
        answerIsFocused = !gameEnded

        self.answer = ""

        if !gameEnded {
            createProblem()
        } else {
            isReady = false
        }
    }

    private func createProblem() {
        leftOperand = multiplicationTables.randomElement() ?? 0
        rightOperand = Int.random(in: 2...9)
    }
}

struct Multiplicate_Previews: PreviewProvider {
    static var previews: some View {
        Multiplicate()
    }
}
