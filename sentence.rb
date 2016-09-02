# 説明文などを表示するモジュール
module Sentence
  def description  # ゲームの説明文
    puts " please choose coordinates"
    puts " insert x y in intger(1<=(x, y)<=3)"
    puts ' for example, player1(o) insert "1 3"...top right point changes "o"'
    puts ' for example, player2(x) insert "2 2"...center point changes "x"'
    puts "\n let's play game!"
  end

  def finish(winner)  # 結果発表
    puts winner.zero? ?
      " draw game..." :  # 引き分けの時
      " winner : player#{winner}"  # 勝敗が決まったとき
    puts " thanks for playing!"
    exit(0) # 正常終了
  end

  module_function :description, :finish
end
