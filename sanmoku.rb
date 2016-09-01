# 座標を入力するメソッド
def input_xy
  print " "
  x, y = gets.split.map(&:to_i)
end

# 表を表示するメソッド
def print_table(table)
  puts ""
  5.times do |i|
    print " "
    5.times { |j| print table[i][j] }
    puts ""
  end
  puts ""
end

# 記号を正しい座標に入力させるメソッド
def choice(table, player_num)
  x, y = [0, 0]
  loop do  # 正しい入力がされない間ループ
    x, y = input_xy
    # 座標外または"1a"(値は1)などを入力されたとき
    if (!(1..3).include?(x) || !(1..3).include?(y) || x.to_s.size!=1 || y.to_s.size!=1)
      puts " please insert x y in intger(1 <= (x, y) <= 3)"
      puts ' "x y" (x and space and y in lower case)'
    # 記号が入っている座標を入力されたとき
    elsif table[(x - 1) * 2][(y - 1) * 2]!=" "
      puts " there is a mark, choose empty coordinates"
      puts " please insert other coordinates"
    # 正しい座標を入力されたとき
    else
      break
    end
  end
  table[(x - 1) * 2][(y - 1) * 2] = player_num.zero? ? "o" : "x"
  print_table(table)
  table
end

def judge(table, player_num)
  mark = player_num.zero? ? "o" : "x"
  count = Array.new(4, 0)
  3.times do |i|
    count[0..1]=[0, 0]
    3.times do |j|
      table[i * 2][j * 2] == mark ? count[0] += 1 : nil  # 横のカウント
      table[j * 2][i * 2] == mark ? count[1] += 1 : nil  # 縦のカウント
    end
    count.include?(3) ? (return player_num + 1) : nil  # 横か縦の列が揃っていたら勝者の番号を返す
    table[i * 2][i * 2] == mark ? count[2] += 1 : nil  # 右斜めのカウント
    table[i * 2][4 - i * 2] == mark ? count[3] += 1 : nil  # 左斜めのカウント
  end
  return count.include?(3) ? player_num + 1 : 0  # 斜めの列が揃っていたら勝者の番号を返す
end

# 表の作成
table = Array.new(5)
5.times do |i|
  table[i] =
    i.even? ? [" ","|"," ","|"," "] : ["-","-","-","-","-"]
end

# 説明
puts " please choose coordinates"
puts " insert x y in intger(1<=(x, y)<=3)"
puts ' for example, you(o) insert "1 3"...'
table[0][4]="o"
print_table(table)
table[0][4]=" "
puts " if you get a line with same mark, you'll be winner!\n\n"

# ゲーム開始
puts " let's play game!"
print_table(table)
winner = 0  # winnerの初期化
9.times do |i|
  puts i.even? ?
    " player1(o) : please choose coordinates" :
    " player2(x) : please choose coordinates"
  table = choice(table, i%2)
  if i >= 4  # 一方が3個以上選択したとき
    winner = judge(table, i%2)
    winner.zero? ? nil : break
  end
end
print_table(table)
# ゲーム終了
puts winner.zero? ?
  " draw game..." :  # 引き分けの時
  " winner : player#{winner}"  # 勝敗が決まったとき
puts " thanks for playing!"
