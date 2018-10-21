var count: Int = 0;

print("Spades!!!!!!!!!!!!!!!!!");
for values in Deck.allSpades{
    print(values)
}
print("Diamonds!!!!!!!!!!!!!!!!!");
for values in Deck.allDiamonds{
    print(values)
}
print("Hearts!!!!!!!!!!!!!!!!!");
for values in Deck.allHearts{
    print(values)
}
print("Clubs!!!!!!!!!!!!!!!!!");
for values in Deck.allClubs{
    print(values)
}
print("All!!!!!!!!!!!!!!!!!");
for values in Deck.allCards{
    print(values)
    count += 1
}
print("Total cart: \(count)")
