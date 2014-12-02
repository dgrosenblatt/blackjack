class Deck
  attr_accessor :cards, :number_of_decks

  def initialize(number_of_decks = 1)
    @cards = []
    @number_of_decks = number_of_decks
    create_deck
  end

  def create_deck
    @number_of_decks.times do
      Card.suits.each do |suit|
        Card.ranks.each do |rank|
          @cards << Card.new(suit, rank)
        end
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
