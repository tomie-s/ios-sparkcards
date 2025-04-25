import SwiftUI

struct DeckDetailView: View {
    let deck: Deck
    @State private var selectedTab = 0
    @State private var showingStudyView = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Segmented Control
            Picker("View", selection: $selectedTab) {
                Text("Study").tag(0)
                Text("Browse").tag(1)
                Text("Settings").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Today's Assignment
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Today's assignment")
                            .font(.headline)
                        
                        HStack(spacing: 16) {
                            AssignmentCard(title: "New cards", count: deck.stats.newCardsToday, total: 40)
                            AssignmentCard(title: "To review", count: deck.stats.toReviewToday, total: 5)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Overall Stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Overall stats")
                            .font(.headline)
                        
                        HStack {
                            Text("\(Int(deck.stats.grade * 100))%")
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                StatRow(label: "Again", count: deck.stats.difficultyDistribution.again, color: .red)
                                StatRow(label: "Hard", count: deck.stats.difficultyDistribution.hard, color: .yellow)
                                StatRow(label: "Good", count: deck.stats.difficultyDistribution.good, color: .green)
                                StatRow(label: "Easy", count: deck.stats.difficultyDistribution.easy, color: .blue)
                            }
                        }
                        
                        ProgressBar(progress: deck.stats.grade)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Additional Stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Additional stats")
                            .font(.headline)
                        
                        StatRow(label: "Total viewed cards", count: deck.stats.totalViewed, total: deck.cardCount)
                        StatRow(label: "Cards studied today", count: deck.stats.cardsStudiedToday, total: 45)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                .padding()
            }
            
            // Study Button
            Button(action: { showingStudyView = true }) {
                Text("Study")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle(deck.name)
        .navigationBarItems(
            trailing: HStack {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        )
        .fullScreenCover(isPresented: $showingStudyView) {
            StudyView(deck: deck)
        }
    }
}

struct AssignmentCard: View {
    let title: String
    let count: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(count)/\(total)")
                .font(.title2)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

struct StatRow: View {
    let label: String
    let count: Int
    var total: Int? = nil
    var color: Color? = nil
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            if let total = total {
                Text("\(count)/\(total)")
            } else {
                Text("\(count)")
            }
            if let color = color {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct ProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: 8)
                    .foregroundColor(.blue)
            }
            .cornerRadius(4)
        }
        .frame(height: 8)
    }
}

#Preview {
    NavigationView {
        DeckDetailView(deck: Deck(
            name: "Neri's Chinese Course",
            cardCount: 111583,
            stats: DeckStats(
                totalViewed: 101,
                cardsStudiedToday: 0,
                newCardsToday: 0,
                toReviewToday: 0,
                grade: 0.87,
                difficultyDistribution: DifficultyDistribution(again: 0, hard: 4, good: 29, easy: 68)
            )
        ))
    }
} 