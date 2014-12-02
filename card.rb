class Card
  attr_accessor :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def Card.suits
    ['♠', '♣', '♥', '♦']
  end

  def Card.ranks
    ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  end

  def paint?
    rank == 'J' ||
    rank == 'Q' ||
    rank == 'K'
  end

  def ace?
    rank == 'A'
  end
end
