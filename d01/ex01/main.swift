var card1 = Card(c: Color.Clubs, v: Value.ace)
var card2 = Card(c: Color.Clubs, v: Value.ace)
var card3 = Card(c: Color.Diamonds, v: Value.two)
var sss = 0

print(card1)
print(card2)
print(card1.isEqual(card2))
print(card1.isEqual(card3))
print(card1.isEqual(sss))
print(card1 == card2)
