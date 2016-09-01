# 座標を入力するメソッド
def input_xy
  print " "
  x, y = gets.split.map(&:to_i)
  x ||= 0  # 入力がないとき0を代入
  y ||= 0
  return x, y
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
  x, y = input_xy
  loop do  # 正しい入力がされない間ループ
    # 座標外を入力されたとき
    if (!(1..3).include?(x) || !(1..3).include?(y))
      puts " please insert x y in intger(1 <= (x, y) <= 3)"
      puts " \"x y\"(x and space and y in lower case)"
      x, y = input_xy
    # 記号が入っている座標を入力されたとき
    elsif table[(x - 1) * 2][(y - 1) * 2]!=" "
      puts " there is a mark, choose empty coordinates"
      puts " please insert other coordinates"
      x, y = input_xy
    # 正しい座標を入力されたとき
    else
      break
    end
  end
    
    table[(x - 1) * 2][(y - 1) * 2] = player_num.zero? ? "o" : "x"
    print_table(table)
    return table
end

def judge(table)
  o_count=[0,0,0,0]  # 縦, 横, 右斜め, 左斜め確認用配列
  x_count=[0,0,0,0]
  3.times do |i|
    o_count[0..1]=[0, 0]
    x_count[0..1]=[0, 0]
    3.times do |j|
      if(table[i * 2][j * 2] == "o") # 縦列のoxカウント
        o_count[0] += 1
      elsif(table[i * 2][j * 2] == "x")
        x_count[0] += 1
      end
      if(table[j * 2][i * 2] == "o") # 横列のoxカウント
        o_count[1] += 1
      elsif(table[j * 2][i * 2] == "x")
        x_count[1] += 1
      end
    end
    if(o_count[0] == 3 || o_count[1] == 3) # 縦・横列でoが揃っているとき
      return 1
    elsif(x_count[0] == 3 || x_count[1] == 3) # 縦・横列でxが揃っているとき
      return 2
    end

    if(table[i * 2][i * 2] == "o") # 右斜め列のoxカウント
      o_count[2] += 1
    elsif(table[i * 2][i * 2] == "x")
      x_count[2] += 1
    end
    if(table[i * 2][4 - i * 2] == "o") # 左斜め列のカウント
      o_count[3] += 1
    elsif(table[i * 2][4 - i * 2] == "x")
      x_count[3] += 1
    end
  end
  if(o_count[2] == 3 || o_count[3] == 3)  # 斜め列でoが揃っているとき
    return 1
  elsif(x_count[2] == 3 || x_count[3] == 3)  # 斜め列でxが揃っているとき
    return 2
  end

  return 0  # どの列も揃っていないとき
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
puts " for example, you(o) insert \"1 3\"..."
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
    winner = judge(table)
    winner.zero? ? nil : break
  end
end

# ゲーム終了
puts winner.zero? ?
  " draw game..." :  # 引き分けの時
  " winner : player#{winner}"  # 勝敗が決まったとき
puts " thanks for playing!"
