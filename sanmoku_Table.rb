require "./sanmoku_Game.rb"

# 表に関するクラス
class Table
  def make  # 表を作成する
    @@table = Array.new(5)
    5.times do |i|
      @@table[i] =
        i.even? ? [" ","|"," ","|"," "] : ["-","-","-","-","-"]
    end
  end

  def init(x, y)  # 引数の座標に記号を代入する
    @@table[(x - 1) * 2][(y - 1) * 2] = 
      Game.new.player_num.zero? ? "o" : "x"
    print_table
  end

  def print_table  # 表を表示する
    puts ""
    5.times do |i|
      print " "
      5.times { |j| print @@table[i][j] }
      puts ""
    end
    puts ""
  end

  def mark(x, y)  # 引数の座標の記号を返す
    @@table[(x - 1) * 2][(y - 1) * 2]
  end
end
