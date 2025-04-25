import Foundation

struct Card: Identifiable, Codable {
    let id: UUID
    var chinese: String
    var pinyin: String
    var english: String
    var lastReviewed: Date?
    var nextReview: Date?
    var difficulty: CardDifficulty
    var reviewCount: Int
    
    init(id: UUID = UUID(), chinese: String, pinyin: String, english: String, lastReviewed: Date? = nil, nextReview: Date? = nil, difficulty: CardDifficulty = .new, reviewCount: Int = 0) {
        self.id = id
        self.chinese = chinese
        self.pinyin = pinyin
        self.english = english
        self.lastReviewed = lastReviewed
        self.nextReview = nextReview
        self.difficulty = difficulty
        self.reviewCount = reviewCount
    }
}

enum CardDifficulty: String, Codable {
    case new
    case again
    case hard
    case good
    case easy
    
    var interval: TimeInterval {
        switch self {
        case .new: return 0
        case .again: return 60 // 1 minute
        case .hard: return 600 // 10 minutes
        case .good: return 86400 // 1 day
        case .easy: return 345600 // 4 days
        }
    }
    
    var color: String {
        switch self {
        case .new: return "gray"
        case .again: return "red"
        case .hard: return "yellow"
        case .good: return "green"
        case .easy: return "blue"
        }
    }
} 