require "./sanmoku_Table.rb"

# 入力に関するモジュール
module Choice
  def input_xy  # 2つの数値を入力させる
    print " "
    x, y = gets.split.map(&:to_i)
    [x ||= 0, y ||= 0]
  end

  def input_check  # 正しい入力をさせる
    x, y = [0, 0]
    loop do
      x, y = input_xy
      # 座標外または"1a"(値は1)などを入力されたとき
      if (!(1..3).include?(x) || !(1..3).include?(y) || x.to_s.size!=1 || y.to_s.size!=1)
        puts " please insert x y in intger(1 <= (x, y) <= 3)"
        puts ' "x y" (x and space and y in lower case)'
      # 記号が入っている座標を入力されたとき
      elsif Table.new.mark(x, y) != " "
        puts " there is a mark, choose empty coordinates"
        puts " please insert other coordinates"
      # 正しい座標を入力されたとき
      else
        break
      end
    end
    [x, y]
  end

  def choice  # 正しく入力をして記号を挿入
    x, y = input_check
    Table.new.init(x, y)
  end

  module_function :input_xy, :input_check, :choice
end
