class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def hit(card)
    @cards << card
  end

  def score
    score = 0
    @cards.each do |card|
      if card.paint?
        score += 10
      elsif card.ace?
        if score + 11 > 21
          score += 1
        else
          score += 11
        end
      else
        score += card.rank.to_i
      end
    end
    score
  end
end
