class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card.suits.each do |suit|
      Card.ranks.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
