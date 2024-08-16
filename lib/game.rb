class Game
  def initialize
    @max_turns = 10
    @turns = 0
    choose_game_mode
  end

  def choose_game_mode
    puts "Choose game mode: 1 for Single-player (computer-generated code), 2 for Two-player (human-set code)"
    mode = gets.chomp.to_i

    if mode == 2
      @code = Code.new(true)
    else
      @code = Code.new
    end
    
    @player = Player.new
  end

  def play
    until game_over?
      guess = @player.get_guess
      feedback = @code.check_guess(guess)
      
      puts "Correct positions: #{feedback[:correct_position]}, Correct colors: #{feedback[:correct_color]}"
      @turns += 1
    end

    if win?
      puts "Congratulations! You've cracked the code!"
    else
      puts "You've run out of turns! The code was #{@code.secret_code.join}."
    end
  end

  def game_over?
    win? || @turns >= @max_turns
  end

  def win?
    @code.secret_code == @player.get_guess
  end
end
