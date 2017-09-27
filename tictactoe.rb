require 'set'

class TicTacToe
  def initialize
    @winning_sets = [
      Set[1,2,3],
      Set[4,5,6],
      Set[7,8,9],
      Set[1,4,7],
      Set[2,5,8],
      Set[3,6,9],
      Set[1,5,9],
      Set[7,5,3]
    ]
    @user1 = User.new('User1')
    @user2 = User.new('User2')
    @current_user = @user1play
  end

  def play
    until winner?
      print "#{@current_user.name}, choose a number from 1-9: "
      input = gets.strip
      mark_position(input) if valid?(input)
    end
    puts "The winner is, #{winner?.name}"
  end
  
  def winner?
    return @user1 if @winning_sets.any? { |w| w.subset?(@user1.answers) }
    return @user2 if @winning_sets.any? { |w| w.subset?(@user2.answers) }
  end
  def valid?(input)
    if input.to_s.scan(/^\d$/).none?
      puts "Provide a number between 1-9"
      return false
    end
    if @user1.answers.one? { |n| n == input } || @user2.answers.one? { |n| n == input }
      puts "This number has already been picked"
      return false
    end
    true
  end
  def mark_position(input)
    @current_user.answers.add(input.to_i)
    @current_user = @current_user == @user1 ? @user2 : @user1
  end
end
class User < Struct.new(:name, :answers)
  def initialize(name)
    self.name, self.answers = name, Set[]
  end
end
