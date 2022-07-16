# frozen_string_literal: true

module Mastermind
  # Mastermind Game
  class Game
    def initialize
      @code = '0000'
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
      puts 'Computer yet to be implemented'
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
      @solved = solved?(trial) until @solved == true
      puts "You found the code (#{@code}) in #{@attempt - 1} attempts !"
    end

    def solved?(answer)
      result = @code == answer.to_i
      puts "Wrong code, try again #{found(answer)}" unless result
      result
    end

    def trial
      code = ''
      until code.length == 4 && code.split('').all? { |char| char.to_i.between?(1, 6) }
        puts "Attempt ##{@attempt}: What is the password (4 numbers between 1 and 6) ?"
        code = gets.chomp
      end
      @attempt += 1
      code
    end

    def found(answer)
      answer = answer.split('')
      code = @code.to_s.split('')
      found_array = exact_match(code, answer)
      answer.each_with_index do |val, idx|
        if code.include?(val) && found_array[idx].zero?
          found_array[idx] = 1
          code[code.index(val)] = 'f'
        end
      end
      found_array.sort.reverse!
    end

    def exact_match(code, answer)
      array = [0, 0, 0, 0]
      answer.each_with_index do |val, idx|
        if val == code[idx]
          array[idx] = 2
          code[idx] = 'f'
        end
      end
      array
    end
  end
end

include Mastermind

Game.new
