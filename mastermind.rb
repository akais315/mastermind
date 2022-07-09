# frozen_string_literal: true

module Mastermind
  # Mastermind Game
  class Game
    def initialize(code)
      @code = code
      start_game
    end

    def start_game
      puts 'Welcome to Mastermind !'
      role = nil
      until %w[m b].include?(role)
        puts 'Will you be the Maker(m) or the Breaker(b) ?'
        role = gets.chomp
      end
    end
  end
end

include Mastermind

Game.new(1234)
