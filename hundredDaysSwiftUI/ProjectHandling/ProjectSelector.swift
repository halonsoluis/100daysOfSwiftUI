// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ProjectSelector: View {

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("WeSplit", destination: WeSplit())

            }
            .navigationTitle("100 days of SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProjectSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelector()
    }
}
