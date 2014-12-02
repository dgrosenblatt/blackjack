require_relative 'hand.rb'
require_relative 'deck.rb'
require_relative 'card.rb'

class Blackjack
  def initialize(balance, deck)
    @deck = deck
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @balance = balance
    start_game
  end

  def start_game
    receive_bet

    @player_hand.hit(@deck.pop)
    puts "Player was dealt the #{@player_hand.cards.last.rank}#{@player_hand.cards.last.suit}"
    sleep 1
    @dealer_hand.hit(@deck.pop)
    puts "Dealer receives a card face down."
    sleep 1
    @player_hand.hit(@deck.pop)
    puts "Player was dealt the #{@player_hand.cards.last.rank}#{@player_hand.cards.last.suit}\n"
    sleep 1
    @dealer_hand.hit(@deck.pop)
    puts "Player has #{@player_hand.score}"
    sleep 1
    puts "Dealer is showing #{@dealer_hand.cards.last.rank}#{@dealer_hand.cards.last.suit}"
    handle_blackjacks

    action
  end

  def action
    player_turn
    dealer_turn
    result
    play_again
  end

  def receive_bet
    puts "You have $#{@balance}."
    puts
    puts "Enter a bet amount:"
    @bet = gets.chomp.to_i
    @balance -= @bet
  end

  def handle_blackjacks
    dealer_turn if @player_hand.score == 21 && @dealer_hand.score == 21
    dealer_turn if @dealer_hand.score == 21
    dealt_blackjack if @player_hand.score == 21
  end

  def dealt_blackjack
    puts "Blackjack!"
    @balance += @bet * 2.5
    play_again
  end

  def player_turn
    puts "Hit or stand (H/S): "
    option = gets.chomp.upcase
    cheat if option == "CHEAT"
    while option[0] != 'H' && option[0] != 'S'
      puts "I'm not sure what that means. Hit or stand?"
      option = gets.chomp.upcase
    end
    player_hit if option[0] == 'H'
    puts "Player stands with #{@player_hand.score}" if option[0] == 'S'
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
    while @dealer_hand.score < 17 || (@dealer_hand.score == 17 && @dealer_hand.number_of_aces > 0)
      @dealer_hand.hit(@deck.pop)
      puts ".."
      sleep 1
      puts "."
      sleep 1
      puts "Dealer was dealt the #{@dealer_hand.cards.last.rank}#{@dealer_hand.cards.last.suit}\n"
      puts "Dealer has #{@dealer_hand.score}"
      sleep 1
    end
    if @dealer_hand.score > 21
      puts "Bust! You win!"
      @balance += @bet * 2
      play_again
    end
  end

  def result
    if @player_hand.score == @dealer_hand.score
      puts "Tie!"
      @balance += @bet
    elsif @player_hand.score > @dealer_hand.score
      puts "You win!"
      @balance += @bet * 2
    else
      puts "You lose!"
    end
  end

  def cheat
    ranks = @deck.map { |card| card.rank }
    face = ranks.count { |rank| rank == '10' || rank == 'J' || rank == 'Q' || rank == 'K' || rank == 'A' }
    mid = ranks.count { |rank| rank.to_i <= 9 && rank.to_i >= 6 }
    low = ranks.count { |rank| rank.to_i <= 5 && rank.to_i >= 2 }
    puts "#{face} monkeys and aces left"
    puts "#{mid} medium cards between 6-9 left"
    puts "#{low} low cards between 2-5 left"
  end

  def play_again
    puts "You now have $#{@balance}"
    if @balance <= 0
      puts "You have no money. Get out."
      exit
    end
    puts "Play again?"
    response = gets.chomp.upcase
    if response[0] == 'Y'
      if @deck.length > 250
        initialize(@balance, @deck)
      else
        puts "Out of cards! Time to shuffle!"
        puts "Where do you want to cut the deck? Enter a number between 1 and 25"
        cut = gets.chomp.to_i
        puts "Shuffling..."
        sleep 3
        puts "Just another moment..."
        sleep 3
        initialize(@balance, Deck.new(6).shuffle.rotate(cut))
      end
    else
      exit
    end
  end

end

Blackjack.new(100, Deck.new(6).shuffle)
