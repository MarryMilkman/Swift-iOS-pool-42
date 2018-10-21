import Foundation

class Deck : NSObject{
    static let allSpades: [Card] = Value.allValues.map{
        (value: Value) -> Card in
        return Card(c: Color.Spades, v: value)
    }
    static let allDiamonds: [Card] = Value.allValues.map{
        (value: Value) -> Card in
        return Card(c: Color.Diamonds, v: value)
    }
    static let allHearts: [Card] = Value.allValues.map{
        (value: Value) -> Card in
        return Card(c: Color.Hearts, v: value)
    }
    static let allClubs: [Card] = Value.allValues.map{
        (value: Value) -> Card in
        return Card(c: Color.Clubs, v: value)
    }

    static let allCards: [Card] = allClubs + allHearts + allDiamonds + allSpades
}