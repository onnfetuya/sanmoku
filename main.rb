require "./player.rb"
require "./sentence.rb"
require "./table.rb"

Sentence.description  # 説明
table = Table.new  # 表の作成と表示
table.make
table.print_table
Player.new.play # ゲーム開始