// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI



///Appealing idea..
///
///Make  recordigns of previous games of the person, in terms of time per qeustion.
///Then, in dependence of the difficulty provide a value to use to increase the empire.
///For now, empire can be red vs blue. even more colors could apply.
///
///- remember the ones you faul often.

struct Multiplicate: View {

    @FocusState private var answerIsFocused: Bool
    @State var leftOperand = 7
    @State var rightOperand = 7
    @State var answer: Int?
    @State var correct = false

    var isCorrectAnswer: Bool {
        leftOperand * rightOperand == answer
    }

    var body: some View {

        HStack(alignment: .center) {
            Text(leftOperand, format: .number)
            Text("x")
            Text(rightOperand, format: .number)
            Text(" = ")

            TextField("__", value: $answer, format: .number)
                .keyboardType(.numberPad)
                .labelsHidden()
                .focused($answerIsFocused)
                .frame(width: 50)
        }
        .font(.largeTitle)
        .foregroundColor(answer == nil
                         ? .primary
                         : isCorrectAnswer
                            ? .green
                            : .red
        )
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    answerIsFocused = !isCorrectAnswer
                }
            }
        }
    }
}

struct Multiplicate_Previews: PreviewProvider {
    static var previews: some View {
        Multiplicate()
    }
}
