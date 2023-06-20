// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ProjectSelector: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {

                NavigationLink("WeSplit", destination: WeSplit())
                NavigationLink("Conversion", destination: Conversion())
                NavigationLink("Flags", destination: Flags())

            }
            .navigationTitle("100 days of SwiftUI")
            .navigationBarTitleDisplayMode(.inline)

        }.ignoresSafeArea()
    }
}

struct ProjectSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelector()
    }
}
