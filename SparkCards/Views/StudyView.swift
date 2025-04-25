import SwiftUI

struct StudyView: View {
    let deck: Deck
    @Environment(\.presentationMode) var presentationMode
    @State private var currentCardIndex = 0
    @State private var showingAnswer = false
    @State private var showingMenu = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: { showingMenu = true }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            // Progress Bar
            ProgressBar(progress: Double(currentCardIndex) / Double(deck.cards.count))
                .frame(height: 4)
                .padding(.horizontal)
            
            // Card Content
            ScrollView {
                VStack(spacing: 20) {
                    if let card = deck.cards[safe: currentCardIndex] {
                        // Chinese Characters
                        Text(card.chinese)
                            .font(.system(size: 48, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding(.top, 40)
                        
                        if showingAnswer {
                            // Pinyin
                            Text(card.pinyin)
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            // English Translation
                            Text(card.english)
                                .font(.title3)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: UIScreen.main.bounds.height * 0.6)
            }
            
            // Bottom Action Area
            VStack(spacing: 16) {
                if showingAnswer {
                    // Difficulty Rating Buttons
                    HStack(spacing: 12) {
                        DifficultyButton(title: "Again", color: .red, interval: "1m") {
                            rateCard(difficulty: .again)
                        }
                        
                        DifficultyButton(title: "Hard", color: .yellow, interval: "10m") {
                            rateCard(difficulty: .hard)
                        }
                        
                        DifficultyButton(title: "Good", color: .green, interval: "1d") {
                            rateCard(difficulty: .good)
                        }
                        
                        DifficultyButton(title: "Easy", color: .blue, interval: "4d") {
                            rateCard(difficulty: .easy)
                        }
                    }
                } else {
                    // Show Answer Button
                    Button(action: { showingAnswer = true }) {
                        Text("Show Answer")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .sheet(isPresented: $showingMenu) {
            StudyMenuView()
        }
    }
    
    private func rateCard(difficulty: CardDifficulty) {
        // Update card difficulty and move to next card
        showingAnswer = false
        currentCardIndex += 1
    }
}

struct DifficultyButton: View {
    let title: String
    let color: Color
    let interval: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(interval)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(color)
            .cornerRadius(12)
        }
    }
}

struct StudyMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Study Options")) {
                    Button("Reset Progress") {
                        // Reset progress action
                    }
                    Button("Change Settings") {
                        // Change settings action
                    }
                }
                
                Section(header: Text("Deck Information")) {
                    Text("Total Cards: 111,583")
                    Text("Cards Studied: 101")
                    Text("Success Rate: 87%")
                }
            }
            .navigationTitle("Study Menu")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    StudyView(deck: Deck(
        name: "Neri's Chinese Course",
        cardCount: 111583,
        cards: [
            Card(chinese: "你好", pinyin: "nǐ hǎo", english: "Hello"),
            Card(chinese: "谢谢", pinyin: "xiè xie", english: "Thank you")
        ]
    ))
} 