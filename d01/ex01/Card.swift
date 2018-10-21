import Foundation

class Card : NSObject{
    var color: Color
    var value: Value

    init(c: Color, v: Value){
        self.color = c
        self.value = v
    }

    override var description: String{
        return ("\(color), \(value.rawValue)");
    }

    override func isEqual(_ object: Any?) -> Bool {
        let other = object as? Card
        if (other != nil){
            if (self.color == other!.color && self.value == other!.value){
                return (true)
            }
        }
        return false
    }

    static func ==(c1: Card, c2: Card) -> Bool{
        if (c1.color == c2.color && c1.value == c2.value){
            return (true)
        }
        return false
    }
}