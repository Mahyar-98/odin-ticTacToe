# frozen_string_literal: true

# This class contains the functions related to the game
class Game
  attr_reader :winner_char, :player1_name, :player2_name
  @@game_UI = '
                 1 | 2 | 3
                ---+---+---
                 4 | 5 | 6
                ---+---+---
                 7 | 8 | 9
  '
  @@positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

  def initialize
    @round_count = 0
    @round_UI = @@game_UI.dup
    @round_positions = @@positions.dup
    @winner_char = 'none'
    puts "\nWhat name do you wanna choose as the player 1?"
    @player1_name = gets.chomp
    puts "\nWhat name do you wanna choose as the player 2? (It cannot be #{player1_name})."
    @player2_name = gets.chomp
  end

  def play
    %w[X O].cycle.first(9).each do |char|
      @round_count += 1
      name = char == 'X' ? player1_name : player2_name
      puts "\n\nIt's #{name}'s turn. Enter a number:\n #{@round_UI}"
      num = gets.chomp.to_i
      round(num, char)
      if @winner_char != 'none'
        puts "\n\n#{name} has won! #{@round_UI}"
        break
      end
      puts "\n\nIt's a draw!" if @round_count == 9
    end
  end

  def round(num, char)
    puts 'Error! Choose another number next turn!' unless @@positions.flatten.include?(num)
    @round_UI.gsub!(num.to_s, char)
    (0..2).to_a.each do |i|
      (0..2).to_a.each do |j|
        @round_positions[i][j] = char if @round_positions[i][j] == num
      end
    end
    declare_winner
  end

  def declare_winner
    @diagonal = [[], []]
    @lines = []
    @round_columns = @round_positions.first.zip(@round_positions[1], @round_positions[2])
    (0..2).to_a.each do |i|
      @diagonal[0].push(@round_positions[i][i])
      @diagonal[1].push(@round_positions[i][2 - i])
    end
    @lines = @round_positions.concat(@round_columns, @diagonal)
    @lines.each { |line| @winner_char = line.uniq if line.uniq.size == 1 }
  end
end

game1 = Game.new
game1.play
