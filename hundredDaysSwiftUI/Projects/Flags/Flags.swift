// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI
import AVFoundation

extension View {
    func leveled() -> some View {
        modifier(LeveledModifier())
        
    }
}

struct Flags: View {
    
    @State private var contestantFlags = FlagCode.flags.keys.shuffled().prefix(4)
    @State private var correctAnswer = Int.random(in: 0..<4)
    
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var waiting = false
    
    private func desiredCountryName() -> String {
        Locale.current
            .localizedString(
                forRegionCode: contestantFlags[correctAnswer]
            )!
    }
    
    @State private var displayMessage = false
    @State private var displayFinalScore = false
    @State private var attempts = 0
    @State private var score = 0
    
    @State private var selectedFlagRotation = 0.0
    @State private var flagScaleAppearAnimationValue = 0.5
    @State private var selectedFlag: Int = -1
    
    var body: some View {
        ZStack {
            
            RadialGradient(
                colors: [.red, .blue],
                center: .top,
                startRadius: 300,
                endRadius: 600
            )
            .ignoresSafeArea()
            
            VStack {
                
              Spacer()
                
                VStack() {
                    
                    Text("Select the flag for")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    Text(desiredCountryName())
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                    
                    GridStack(rows: 2, cols: 2) { index in
                        Button {
                            
                            withAnimation(.easeInOut) { 
                                selectedFlag = index
                                userSelected(flag: contestantFlags[index])
                            }
                            waiting = true
                         
                                  //  AudioServicesPlaySystemSound(1023)
                            
                        } label: {
                            VStack(spacing: -10) {
                            
                            FlagImage(
                                countryCode: contestantFlags[index],
                                isSelected: !waiting && selectedFlag == index,
                                isCorrect: !waiting && index == correctAnswer
                            )
                           
                            Text("\(country(contestantFlags[index]))")
                                .opacity(waiting ? 1 : 0)
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                            }
                        }
                        
                        
                    }
                    .alert(scoreTitle, isPresented: $displayFinalScore) {
                        Button("New Game", action: reset)
                    } message: {
                        Text(message)
                            .foregroundColor(.white)
                    }
                    
                    
                }
                .leveled()
                
                
                
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: showNewFlags, label: {
                    Text("Continue")
                        .opacity(waiting ? 1 : 0)
                        .foregroundColor(.white)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular), style: FillStyle())
                        .backgroundStyle(.primary)
                        .shadow(radius: 5)
                })
                
                 
                
            }
            .navigationTitle("Guess the flag")
        }
    }
    
    private func country(_ code: String) -> String {
        Locale.current
            .localizedString(
                forRegionCode: code
            )!
    }
    
    private func userSelected(flag: String) {
        guard !waiting else {
            return
        }
        
        let correct = contestantFlags[correctAnswer] == flag
        
        score = score + (correct ? 1 : 0)
        scoreTitle = correct ? "Correct" : "Wrong"
        
        message = correct
        ? "Great! Get ready for the next set."
        : "That's the flag of \(country(flag))"
        
        displayMessage = true
    }
    
    private func showNewFlags() {
        selectedFlag = -1
        waiting = false
        
        guard attempts < 9 else {
            displayFinalScore = true
            scoreTitle = "Game Over"
            message = "Your final score is \(score)"
            return
        }
        contestantFlags = FlagCode.flags.keys.shuffled().prefix(4)
        correctAnswer = Int.random(in: 0..<4)
        attempts = attempts + 1
        
        selectedFlagRotation = 0
        flagScaleAppearAnimationValue = 0.5
    }
    
    private func reset() {
        attempts = -1
        score = 0
        showNewFlags()
    }
}

struct Flags_Previews: PreviewProvider {
    static var previews: some View {
        Flags()
    }
}

