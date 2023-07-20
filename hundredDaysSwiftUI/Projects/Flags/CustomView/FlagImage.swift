import SwiftUI

struct FlagImage: View {
    var countryCode: String
    var isSelected: Bool
    var isCorrect: Bool
    
    var body: some View {
        Text(FlagCode.flags[countryCode]!)
            .font(.system(size: 150))
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(isSelected && !isCorrect ? 180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                anchor: .center,
                anchorZ: 0.0,
                perspective: 1.0
            )
            .scaleEffect(
                isSelected && isCorrect ? CGSize(width: 1.5, height: 1.5) : .init(width: 1, height: 1),
                anchor: .center
            )
    }
}
