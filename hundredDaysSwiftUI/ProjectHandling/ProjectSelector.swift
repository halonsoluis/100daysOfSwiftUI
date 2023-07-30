// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ProjectSelector: View {

    var body: some View {
            NavigationStack {

                ZStack {

                    RadialGradient(
                        colors: [
                            .red,
                            .red.opacity(0.1),
                            .black,
                            .red.opacity(0.5),
                            .red.opacity(0.8),
                            .red,
                            .black,
                            .black
                        ],
                        center: .leading,
                        startRadius: 00,
                        endRadius: 800
                    )
                        .ignoresSafeArea()
                        .background(Color.black)

                VStack(alignment: .leading, spacing: 10) {

                    NavigationLink("WeSplit", destination: WeSplit())
                    NavigationLink("Conversion", destination: Conversion())
                    NavigationLink("Flags", destination: Flags())
                    NavigationLink("RockPaperScissors", destination: RockPaperScissors())
                    NavigationLink("Scramble", destination: Scramble())
                    NavigationLink("Multiplicate", destination: Multiplicate())
                    NavigationLink("iExpense", destination: iExpense())

                }
                .padding(20)
                .font(.title)
                .foregroundColor(.white)
                .navigationTitle("100 days of SwiftUI")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ProjectSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelector()
    }
}
