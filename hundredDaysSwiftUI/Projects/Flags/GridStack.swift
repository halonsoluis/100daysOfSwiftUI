import SwiftUI

struct GridStack <Content: View>: View {
    let rows: Int
    let cols: Int
    let content: (Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<cols, id: \.self) { column in
                        content(row * cols + column)
                    }
                }
            }
        }
    }
}
