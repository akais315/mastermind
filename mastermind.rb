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
      case choose_role
      when 'b'
        Breaker.new
      when 'm'
        Maker.new
      end
    end

    def choose_role
      role = nil
      until %w[m b].include?(role)
        puts 'Will you be the Maker(m) or the Breaker(b) ?'
        role = gets.chomp.downcase
      end
      role
    end
  end

  # Maker game
  class Maker
    def initialize
      puts 'Maker initialized'
      generate_code
    end

    def generate_code
      @code = ''
      until @code.length == 4 && @code.split('').all? { |char| char.to_i.between?(1, 6) }
        puts 'What code will the computer try to crack (4 numbers between 1 and 6)?'
        @code = gets.chomp
      end
    end
  end

  # Breaker game
  class Breaker
    def initialize
      puts 'Breaker initialized'
      @attempt = 1
      @code = generate_code
      puts @code
      @solved = false
      solve
    end

    def generate_code
      code = ''
      4.times { code += rand(1..6).to_s }
      code.to_i
    end

    def solve
      until @solved == true
        @solved = solved?(trial)
      end
    end

    def solved?(trial)
      @code == trial.to_i
    end

    def trial
      code = ''
      until code.length == 4 && code.split('').all? { |char| char.to_i.between?(1, 6) }
        puts "Attempt ##{@attempt}: What is the passord (4 numbers between 1 and 6) ?"
        code = gets.chomp
      end
      @attempt += 1
      code
    end
  end
end

include Mastermind

Game.new(1234)
