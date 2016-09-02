require "./sanmoku_Game.rb"
require "./sanmoku_Rule.rb"
require "./sanmoku_Table.rb"

# 勝敗を確認するモジュール
module Judge
  def row(mark, i)  # 横列の記号(mark)の個数を返す
    count = 0
    3.times { |j| Table.new.mark(i, j + 1) == mark ? count += 1 : nil }
    count
  end

  def column(mark, i)  # 縦列の記号(mark)の個数を返す
    count = 0
    3.times { |j| Table.new.mark(j + 1, i) == mark ? count += 1 : nil }
    count
  end

  def diagonal(mark)  # 斜め列の記号(mark)の個数を返す
    count = [0, 0]
    3.times do |j|
      Table.new.mark(j + 1, j + 1) == mark ? count[0] += 1 : nil
      Table.new.mark(j + 1, 2 - j + 1) == mark ? count[1] += 1 : nil
    end
    count
  end

  def judge  # 列が揃っているか
    mark = Game.new.player_num.zero? ? "o" : "x"
    3.times do |i|
      if ([row(mark, i + 1), column(mark, i + 1)].include?(3) || diagonal(mark).include?(3)) ?
        Rule.finish(Game.new.player_num + 1) : nil
      end
    end
  end

  module_function :row, :column, :diagonal, :judge
end
