class Square
  attr_accessor :row, :column, :value, :valid_moves, :predecessor

  def initialize(row, column)
    @row = row
    @column = column
    @value = [row, column]
    @valid_moves = find_valid_moves(row, column)
    @predecessor = nil
  end

  def find_valid_moves(row, column)
    valid_moves = []
    displacements = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
    displacements.each do |displace_by|
      displaced_row  = row + displace_by[0]
      displaced_column = column + displace_by[1]
      valid_moves << [displaced_row, displaced_column] if displaced_row.between?(0,7) and displaced_column.between?(0,7)
    end
    valid_moves
  end
end

class Board
  attr_accessor :board, :queue

  def initialize
    #@visited = []
    #@queue = []
    @board = []
    8.times do |row|
      @board << []
      8.times do |column|
        @board[row] << Square.new(row,column)
      end
    end
  end

  def knight_move(start, finish) #in the form of [a,b],[c,d]
    puts "starting square: #{start}"
    puts "target square: #{finish}"
    @queue = []
    @visited = []
    start_square = @board[start[0]][start[1]]
    move = search(finish, start_square)
    print_path(move)
    reset
  end

  def search(target, curr_square)
    if curr_square.nil?
      return nil
    elsif curr_square.value == target
      return curr_square
    else
      @visited << curr_square.value
      curr_square.valid_moves.each do |move|
        unless @visited.include? move or @queue.include? move
          next_square = @board[move[0]][move[1]]
          next_square.predecessor = curr_square
          @queue << next_square.value
        end
      end
      next_test = @queue.shift
      search(target, @board[next_test[0]][next_test[1]])
    end
  end

  def print_path(move)
    print_path(move.predecessor) if move.predecessor != nil
    p move.value
  end

  def reset
    @board.each do |row|
      row.each do |square|
        square.predecessor = nil
      end
    end
  end
end

a = Board.new
a.knight_move([0,0],[2,3])
puts "\n\n"
a.knight_move([1,6],[2,3])
puts "\n\n"
a.knight_move([5,4],[1,3])
puts "\n\n"
a.knight_move([0,3],[6,7])
