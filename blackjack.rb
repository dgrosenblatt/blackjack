require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'card.rb'

require 'pry'

# betting
# double down
# blackjacks / insurance
# surrender
# splitting
# dealer hit on soft 17
# multiple decks that don't get reshuffled right away


class Blackjack
  def initialize(balance)
    @deck = Deck.new.shuffle
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @balance = balance
    start_game
  end

  def start_game
    @player_hand.hit(@deck.pop)
    puts "Player was dealt the #{@player_hand.cards.last.rank}#{@player_hand.cards.last.suit}"
    sleep 1
    @dealer_hand.hit(@deck.pop)
    puts "Dealer receives a card face down."
    sleep 1
    @player_hand.hit(@deck.pop)
    puts "Player was dealt the #{@player_hand.cards.last.rank}#{@player_hand.cards.last.suit}"
    puts
    sleep 1
    @dealer_hand.hit(@deck.pop)
    puts "Player has #{@player_hand.score}"
    sleep 1
    puts "Dealer is showing #{@dealer_hand.cards.last.rank}#{@dealer_hand.cards.last.suit}"
    action
  end

  def action
    player_turn
    dealer_turn
    result
    play_again
  end

  def player_turn
    puts "Hit or stand (H/S): "
    option = gets.chomp.upcase[0]
    while option[0] != 'H' && option[0] != 'S'
      puts "I'm not sure what that means. Hit or stand?"
      option = gets.chomp.upcase
    end
    player_hit if option == 'H'
    puts "Player stands with #{@player_hand.score}" if option == 'S'
  end

  def player_hit
    @player_hand.hit(@deck.pop)
    puts "Player was dealt the #{@player_hand.cards.last.rank}#{@player_hand.cards.last.suit}"
    puts "Player has #{@player_hand.score}"
    if @player_hand.score > 21
      puts "Bust! You lose!"
      play_again
    end
    sleep 1
    player_turn
  end

  def dealer_turn
    puts "Dealer flips #{@dealer_hand.cards.first.rank}#{@dealer_hand.cards.first.suit}"
    sleep 1
    puts "Dealer has #{@dealer_hand.score}"
    sleep 1
    while @dealer_hand.score < 17
      @dealer_hand.hit(@deck.pop)
      puts ".."
      sleep 1
      puts "."
      sleep 1
      puts "Dealer was dealt the #{@dealer_hand.cards.last.rank}#{@dealer_hand.cards.last.suit}"
      puts
      puts "Dealer has #{@dealer_hand.score}"
      sleep 1
    end
    if @dealer_hand.score > 21
      puts "Bust! You win!"
      play_again
    end
  end

  def result
    if @player_hand.score == @dealer_hand.score
      puts "Tie!"
    elsif @player_hand.score > @dealer_hand.score
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def play_again
    puts "Play again?"
    response = gets.chomp.upcase
    if response[0] == 'Y'
      initialize(@balance)
    else
      exit
    end
  end

end

Blackjack.new(100)
