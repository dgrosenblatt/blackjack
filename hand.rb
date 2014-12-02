class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit(card)
    @cards << card
  end

  def number_of_aces
    @cards.count { |card| card.ace? }
  end

  def score
    score = 0

    @cards.each do |card|
      if card.paint?
        score += 10
      elsif card.ace?
        score += 11
      else
        score += card.rank.to_i
      end
    end

    number_of_aces.times do
      score -= 10 if score > 21
    end

    score
  end
end
