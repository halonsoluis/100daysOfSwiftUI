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

    @State var multiplicationTables = [7, 5, 8, 6, 9]
    @State var questionsToAnswer: Int = 2

    @FocusState private var answerIsFocused: Bool
    @State var leftOperand = 7
    @State var rightOperand = 7
    @State var answer: String = ""
    @State var previousAnswers = [(expression: String, correct: Bool)]()

    var isReady: Bool {
        !multiplicationTables.isEmpty && questionsToAnswer > 0
    }

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

            HStack(alignment: .center) {
                Group {
                    Text(leftOperand, format: .number)
                    Text("x")
                    Text(rightOperand, format: .number)
                    Text(" = ")

                    TextField("__", text: $answer)
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
                .opacity(isReady ? 1 : 0)
            }
            .onAppear(perform: createProblem)
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
        answerIsFocused = questionsToAnswer > 0

        self.answer = ""

        createProblem()
    }

    private func createProblem() {
        leftOperand = multiplicationTables.randomElement() ?? 7
        rightOperand = Int.random(in: 0...10)
    }
}

struct Multiplicate_Previews: PreviewProvider {
    static var previews: some View {
        Multiplicate()
    }
}
