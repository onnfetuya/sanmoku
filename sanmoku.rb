def input_xy
    x, y = gets.split.map(&:to_i)
    x ||= 0  #入力がないとき0を代入
    y ||= 0
end

def print_table(s)  #表の表示
    puts ""
    5.times do |i|
        print " " #左に空白一列
        5.times do |j|
            print s[i][j]
        end
        puts ""
    end
    puts ""
end

def choice(s,p) #s:表,p:player_number
    print " "
    x, y = input_xy
    loop do
        if(x<1 || 3<x || y<1 || 3<y) #マス以外を指定されたとき
            puts " please,insert x y in intger(1<=(x,y)<=3)"
            print " "
            x,y=input_xy
        elsif(s[(x-1)*2][(y-1)*2]!=" ") #すでに記号が存在するマスを指定されたとき
            puts " there is a mark,choose empty coordinates"
            print " "
            x,y=input_xy
        else    #正しいマス指定のとき
            break
        end
    end
    s[(x-1)*2][(y-1)*2] = (p==1) ? "o" : "x"
    print_table(s)  #表を表示
    return s
end

def judge(s)
    o_count2=0;x_count2=0 #右斜め列の確認用
    o_count3=0;x_count3=0 #左斜め列の確認用

    3.times do |i|
        o_count0=0;x_count0=0 #横列の確認用
        o_count1=0;x_count1=0 #縦列の確認用
        3.times do |j|
            if(s[j*2][i*2]=="o") #横列のカウント
                o_count0+=1
            elsif(s[j*2][i*2]=="x")
                x_count0+=1
            end

            if(s[i*2][j*2]=="o") #縦列のカウント
                o_count1+=1
            elsif(s[i*2][j*2]=="x")
                x_count1+=1
            end
        end
        if(o_count0==3 || o_count1==3) #縦・横でoが揃っているか確認
            return 1
        elsif(x_count0==3 || x_count1==3) #縦・横でxが揃っているか確認
            return 2
        end

        if(s[i*2][i*2]=="o") #右斜め列のカウント
            o_count2+=1
        elsif(s[i*2][i*2]=="x")
            x_count2+=1
        end

        if(s[i*2][4-i*2]=="o") #左斜め列のカウント
            o_count3+=1
        elsif(s[i*2][4-i*2]=="x")
            x_count3+=1
        end
    end

    if(o_count2==3 || o_count3==3) #斜めでoが揃っているか確認
        return 1
    elsif(x_count2==3 || x_count3==3) #斜めでxが揃っているか確認
        return 2
    else #どれも揃ってないとき
        return 0
    end 
end

s=Array.new(3)
for i in 0...5  #表の作成
    if(i%2==0)
        s[i]=[" ","|"," ","|"," "]
    else
        s[i]=["-","-","-","-","-"]
    end
end

#説明
puts " please choose coordinates"
puts " insert x y in intger(1<=(x,y)<=3)"
puts " for example"
puts " you(o) insert [1 3]..."
s[0][4]="o"
print_table(s)
s[0][4]=" "
puts " if you get a line with same mark, you'll be winner!",""

#ゲームスタート
puts ""," let's play game!"
print_table(s)
winner=0    #初期化
9.times do |i|
    if(i%2==0)
        puts " player1(o):please choose coordinates"
    else
        puts " player2(x):please choose coordinates"
    end
    s=choice(s,1+i%2)
    if(i>=4)    #一方が3個以上選択したとき
        winner=judge(s)
        if(winner!=0)
            break
        end
    end
end

if(winner==0)
    puts " draw game..."    #引き分け
else
    puts " winner:player#{winner}"  #勝敗が決まったとき
    puts " congratulation!"
end

puts ""," thanks for playing!"   #game終了