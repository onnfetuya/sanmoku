require "./sanmoku_Choice.rb"
require "./sanmoku_Judge.rb"
require "./sanmoku_Rule.rb"

# ゲーム開始から終了までの流れを表すクラス
class Game
  def play
    9.times do |turn|
      @@player_num = turn % 2
      puts @@player_num.zero? ? 
      " player1(o) : please choose coordinates" :
      " player2(x) : please choose coordinates"
      Choice.choice
      turn >= 4 ? Judge.judge : nil
    end
    Rule.finish(0)  # 表が埋まっても勝敗が決まらなかったとき
  end

  def player_num  # playerの番号-1を返す
    @@player_num
  end  
end
