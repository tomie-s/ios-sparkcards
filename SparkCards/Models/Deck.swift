import Foundation

struct Deck: Identifiable, Codable {
    let id: UUID
    var name: String
    var cardCount: Int
    var cards: [Card]
    var lastStudied: Date?
    var stats: DeckStats
    
    init(id: UUID = UUID(), name: String, cardCount: Int = 0, cards: [Card] = [], lastStudied: Date? = nil, stats: DeckStats = DeckStats()) {
        self.id = id
        self.name = name
        self.cardCount = cardCount
        self.cards = cards
        self.lastStudied = lastStudied
        self.stats = stats
    }
}

struct DeckStats: Codable {
    var totalViewed: Int
    var cardsStudiedToday: Int
    var newCardsToday: Int
    var toReviewToday: Int
    var grade: Double
    var difficultyDistribution: DifficultyDistribution
    
    init(totalViewed: Int = 0, cardsStudiedToday: Int = 0, newCardsToday: Int = 0, toReviewToday: Int = 0, grade: Double = 0.0, difficultyDistribution: DifficultyDistribution = DifficultyDistribution()) {
        self.totalViewed = totalViewed
        self.cardsStudiedToday = cardsStudiedToday
        self.newCardsToday = newCardsToday
        self.toReviewToday = toReviewToday
        self.grade = grade
        self.difficultyDistribution = difficultyDistribution
    }
}

struct DifficultyDistribution: Codable {
    var again: Int
    var hard: Int
    var good: Int
    var easy: Int
    
    init(again: Int = 0, hard: Int = 0, good: Int = 0, easy: Int = 0) {
        self.again = again
        self.hard = hard
        self.good = good
        self.easy = easy
    }
} 